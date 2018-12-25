require 'test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

	test "welcome index" do
		get '/welcome/index'
		assert_response 200
	end

end