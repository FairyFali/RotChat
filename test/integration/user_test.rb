require 'test_helper'
# 用户管理
class UserTest < ActionDispatch::IntegrationTest
	test "show user profile" do
	  get '/user_profiles/show'
	  assert_response 302
	end
end