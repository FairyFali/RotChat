require 'test_helper'

class MachinesProfileTest < ActionDispatch::IntegrationTest

	test "show machines profile lists" do
		get '/machines_profiles/1'
		assert_response 302
	end

end