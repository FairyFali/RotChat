# MachinesController的测试
class MachinesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.find(1)
  end

  # 测试machine的主页，未登陆状态下返回302
  test "should get index" do
    get new_user_session_path
    post user_session_path(params: {user: {email: @user.email, password: 'wfl15846066427'}})
    get machines_url
    # assert_response 200
    assert_redirected_to "/users/sign_in"
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