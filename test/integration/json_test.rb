require 'test_helper'

class JsonTest < ActionDispatch::IntegrationTest

	test "show lists" do
		get '/json/machines?query=2'
		assert 200
	end

end