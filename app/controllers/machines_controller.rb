# Machine的Controller，用于展示Machine的信息、查询Machine、对Machine进行评分
class MachinesController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	
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

  

end
