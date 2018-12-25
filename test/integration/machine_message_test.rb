require 'test_helper'

class MachineMessageTest < ActionDispatch::IntegrationTest

	test "show lists" do
		post "/machine_messages"
		assert_response 302
	end

end