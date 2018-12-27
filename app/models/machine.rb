class Machine < ApplicationRecord
	has_many :machineMessages
	has_and_belongs_to_many :users
end

class MachineFactory
	def createMachine(code)
		case code
		when 1
			return TulingMachine.new
		when 2
			return XiaodouMachine.new
		when 3
			return QingyunMachine.new
		else
			return nil
		end
	end
end

# 图灵机器人 code为1
class TulingMachine < Machine
	def send_message_to_api(msg)
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
		        "userId": "1"
		    }
		}.to_json
	    url2 = URI(url)

	    req = Net::HTTP::Post.new(url2, 'Content-Type' => 'application/json')
		req.body = data
		res = Net::HTTP.new(url2.host, url2.port).start {|http| http.request(req)}
		p "send_message_to_api方法，返回数据信息："
		p res.body
		json = res.body
	  	ha = JSON.parse(json)
	  	result = ha["results"][0]["values"]["text"]
	  	p result
		return result
	end
end

# 小豆机器人 code为2
class XiaodouMachine < Machine

	def send_message_to_api(msg)
		url2 = Addressable::URI.parse(url + msg)
		response = Net::HTTP.get_response(url2)
		# 此处编码问题解决了一下
		return response.body.encode("ASCII-8BIT").force_encoding("utf-8")
	end
	
end

# 青云机器人 code为3
class QingyunMachine < Machine
	
	def send_message_to_api(msg)
		url2 = Addressable::URI.parse(url + msg)
		response = Net::HTTP.get_response(url2)
		# 此处编码问题解决了一下
		ha = JSON.parse(response.body.encode("ASCII-8BIT").force_encoding("utf-8"))
		# 替换{br}为空格
		text = ha["content"].gsub("{br}", "<br>")
		return text
	end

end



