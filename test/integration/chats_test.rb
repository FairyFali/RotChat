require 'test_helper'

class ChatsTest < ActionDispatch::IntegrationTest

	test "show chats" do
		get "/chats"
		assert_response 302
	end

end