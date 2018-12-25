require 'test_helper'

class ListTest < ActionDispatch::IntegrationTest

	test "show lists" do
		get "/lists"
		assert_response 302
	end

end