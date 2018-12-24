require 'test_helper'
# 机器人添加管理
class MachineTest < ActionDispatch::IntegrationTest
	# 未登陆状态下不能访问新建机器人页面
	test "can create an machine" do
	  get "/admin/machines/new"
	  assert_response 302
	end
end
