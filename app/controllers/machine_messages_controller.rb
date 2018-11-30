require 'net/http'
require 'uri'
require 'json'
class MachineMessagesController < ApplicationController
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	
	def create
		# 接收用户发来的消息
		user_id = current_user.id
		machine_id = params[:machine_id]
		text = params[:machine_message][:text]
		# 传递参数
		@machine = Machine.find(machine_id)
	  	@user_machines = current_user.machines
	  	@machine_message = MachineMessage.new
		# 创建用户的语句
		machine_message2 = MachineMessage.new(:user_id=>user_id, 
						:machine_id=>machine_id, 
						:text=>text,
						:type2=>1)
		if machine_message2.save
			# 创造machine返回的消息
			msg = send_message_to_api(text, @machine.api_key, @machine.url, user_id)
			machine_message_api = MachineMessage.new(:user_id=>user_id,
						:machine_id=>machine_id,
						:text=>msg,
						:type2=>2)
			if machine_message_api.save
			else
				flash[:alert] = "api消息保存失败"
			end
		else
			flash[:alert] = "消息发送失败"
		end
		@messages = MachineMessage.find_by_sql("select * from machine_messages where user_id = " +
  					current_user.id.to_s +
  					" and machine_id = " +
  					@machine.id.to_s + 
  					" order by created_at asc")
		redirect_to machine_path(@machine)
	end

private
	def send_message_to_api(msg, api_key, url_machine, user_id)
		data = {
		    "reqType": 0,
		    "perception": {
		        "inputText": {
		            "text": msg,
		        },
		    },
		    "userInfo": {
		        # "apiKey": "7992efa1d9d34cb69a201e7ab181f5b9",
		        "apiKey": api_key,
		        "userId": user_id
		    }
		}.to_json
	    url = URI(url_machine)

	    req = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json')
		req.body = data
		res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req)}
		p "send_message_to_api方法，返回数据信息："
		p res.body
		json = res.body
	  	ha = JSON.parse(json)
	  	result = ha["results"][0]["values"]["text"]
	  	p result
		return result
	end
end
