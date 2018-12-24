require 'net/http'
require 'uri'
require 'json'
require 'addressable/uri'

# Machine的Controller，用于展示Machine的信息、查询Machine、对Machine进行评分
class MachinesController < ApplicationController
  # 這個是 devise 提供的方法，先檢查必須登入
  before_action :authenticate_user! , only: [:show, :index, :score] 
	
  # 获得当前用户的机器人信息，返回的页面是和机器人的聊天主页
  def index
  	@user_machines = current_user.machines
  end
  # 展示当前用户的机器人信息，返回的页面是用户的指定机器人的聊天页面，并且展示当前机器人的信息
  def show
  	@machine = Machine.find(params[:id])
  	@user_machines = current_user.machines
  	@machine_message = MachineMessage.new
  	@messages = MachineMessage.find_by_sql(
            "select * from machine_messages where user_id = " +
  					current_user.id.to_s +
  					" and machine_id = " +
  					@machine.id.to_s + 
  					" order by created_at asc")

  end

  # json请求
  # /machines/index_json get
  # 返回json数据的machines数据
  # 模糊查询当前查询的机器人信息
  def index_json
  	p params[:query]
  	machines = Machine.where("name like ?", "%#{params[:query]}%")
  	current_machines = current_user.machines
  	render json: (machines - current_machines).as_json
  end

  # 打分功能
  def score
    machine = Machine.find(params[:id])
    # 这里需要判断
    user_score = params[:machine][:score].to_i * 10
    current_score = machine.score
    new_score = current_score + 6 if user_score > current_score
    new_score = current_score - 6 if user_score < current_score
    new_score = current_user if user_score == current_score
    # 更新打分
    machine.update(:score => new_score)
    flash[:notice] = "评分成功"
    redirect_to '/machines'
  end

  # 新建machine的blog博客
  def create_blog
    machine = Machine.find(params[:id])
    # 异常处理
    begin
      params2 = {}  
      params2["title"] = URI::escape(machine.name)
      params2["text"] = machine.memo
      uri = URI.parse("http://localhost:3000/json/create/blog")
      res = Net::HTTP.post_form(uri, params2)
      #返回的cookie 
      puts res.header['set-cookie']  
      #返回的html body
      puts res.body
      h = JSON.parse(res.body)
      p h
      if h["id"].nil?
        flash[:notice] = "创建博客失败"
      else
        machine.bolg_id = h["id"]
        machine.save
        flash[:notice] = "创建博客成功"
      end
    rescue
      p "抛出异常"
      flash[:notice] = "博客系统异常，不能创建博客"
    ensure
      # 异常模块必须执行的代码
    end
    redirect_to "/machines_profiles/" + machine.id.to_s

  end

  # 获取machine的blog的评论
  def get_blog_comment
    id = params[:id]
    machine = Machine.find(id)
    blog_id = machine.bolg_id
    url = Addressable::URI.parse("http://localhost:3000/json/get/blog/comment?id=" +
          blog_id.to_s)
    response = Net::HTTP.get_response(url)
    p response.body.encode("ASCII-8BIT").force_encoding("utf-8")
    h = JSON.parse(response.body.encode("ASCII-8BIT").force_encoding("utf-8"))
    flash[:comments] = h
    redirect_to "/machines_profiles/" + machine.id.to_s
  end
  

end
