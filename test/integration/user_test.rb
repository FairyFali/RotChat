require 'test_helper'
# 用户管理
class UserTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.find(1)
	end

	test "login with correct information" do
		get new_user_session_path
		post user_session_path(params: {user: {email: @user.email, password: 'wfl15846066427'}})
		# assert_redirected_to root_path
		assert_response 200
		# follow_redirect!
		# assert_template 'homes/index'
		# assert_select "a[href=?]", root_path, count: 2
		# assert_select "a[href=?]", rails_admin_path, count: 0
	end

	test "show user profile" do
		get '/user_profiles/show'
		assert_response 302
	end
end