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
end
