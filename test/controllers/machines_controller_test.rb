# MachinesController的测试
class MachinesControllerTest < ActionDispatch::IntegrationTest
  # 测试machine的主页，未登陆状态下返回302
  test "should get index" do
    get machines_url
    assert_response 302
  end

  test "show machines list" do
  	get "/machines/show"
  	assert_response 302
  end

  # test "index json" do
  # 	get "/machines/index_json?query=%E6%9C%BA%E5%99%A8%E4%BA%BA"
  # 	assert_response 302
  # end
  
  test "score" do
  	post '/machines/score'
  	assert_response 302
  end
end