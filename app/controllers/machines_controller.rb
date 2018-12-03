class MachinesController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	
  def index
  	@user_machines = current_user.machines
  end

  def show
  	@machine = Machine.find(params[:id])
  	@user_machines = current_user.machines
  	@machine_message = MachineMessage.new
  	@messages = MachineMessage.find_by_sql("select * from machine_messages where user_id = " +
  					current_user.id.to_s +
  					" and machine_id = " +
  					@machine.id.to_s + 
  					" order by created_at asc")

  end

  # json请求
  # /machines/index_json get
  # 返回json数据的machines数据
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
