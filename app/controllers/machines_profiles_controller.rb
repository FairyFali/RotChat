class MachinesProfilesController < ApplicationController
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	# 机器人信息展示
	def show
		@machine = Machine.find(params[:id])
		@user_machines = current_user.machines
		# 异常处理
		begin
			if !@machine.bolg_id.nil?
				@comments = get_comments(params[:id])
			end
		rescue
			p "MachinesProfilesController出现异常"
		ensure

		end
	end

private
	def get_comments(id)
	    machine = Machine.find(id)
	    blog_id = machine.bolg_id
	    url = Addressable::URI.parse("http://localhost:3000/json/get/blog/comment?id=" +
	          blog_id.to_s)
	    response = Net::HTTP.get_response(url)
	    p response.body.encode("ASCII-8BIT").force_encoding("utf-8")
	    h = JSON.parse(response.body.encode("ASCII-8BIT").force_encoding("utf-8"))
	    return h
	end
end
