require 'net/http'
require 'uri'
require 'json'
require 'addressable/uri'
# 用户和机器人对话的controller
class MachineMessagesController < ApplicationController
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	
	# 创建用户消息，同时发送给机器人，接受机器人传过来的消息
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
			# 计时
			start_time = Time.new
			# 工厂模式的调用方法
			factory = MachineFactory.new
			m = factory.createMachine(@machine.code)
			m.api_key = @machine.api_key
			m.url = @machine.url
			p m
			# 发送信息给api
			msg = m.send_message_to_api(text)
			end_time = Time.new
			# 计算时间
			duration = (end_time - start_time)*1000000
			# 新的请求次数
			new_req_num = @machine.req_num + 1
			# 新的请求时间
			new_duration = (duration + @machine.duration*@machine.req_num)/new_req_num
			# 更新请求时间和请求次数
			@machine.update({:duration=>new_duration, :req_num=>new_req_num})
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
	# 发送给机器人的消息并且返回结果
	def send_message_to_api1(msg, api_key, url_machine, user_id)
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

	# 多种类型机器人，因为机器人API的不同而需要写不同的方法
	def send_message_to_api2(msg, url)
		url = Addressable::URI.parse(url + msg)
		response = Net::HTTP.get_response(url)
		# 此处编码问题解决了一下
		return response.body.encode("ASCII-8BIT").force_encoding("utf-8")
	end

	# 同理，第三种类型的机器人
	def send_message_to_api3(msg, url)
		ha = JSON.parse(send_message_to_api2(msg, url))
		# 替换{br}为空格
		text = ha["content"].gsub("{br}", "<br>")
		return text
	end

end
