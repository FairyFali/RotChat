class MachinesProfilesController < ApplicationController
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	# 机器人信息展示
	def show
		@machine = Machine.find(params[:id])
		@user_machines = current_user.machines
	end
end
