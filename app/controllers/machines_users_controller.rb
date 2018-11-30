class MachinesUsersController < ApplicationController

	# get /machinesusers?machine_id=
	# 增加用户的机器人API
	def add
		machine_id = params[:machine_id]
		machine = Machine.find(machine_id)
		current_user.machines << machine
		flash[:notice] = "添加机器人成功"
		redirect_to machine_path(machine)
	end

end
