class JsonController < ApplicationController

	# 搜索机器人
	def search_machines
		machines = Machine.where("name like ?", "%#{params[:query]}%")
	  	render json: (machines).as_json
	end

end