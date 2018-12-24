# MachinesController的测试
class MachinesControllerTest < ActionDispatch::IntegrationTest
  # 测试machine的主页，未登陆状态下返回302
  test "should get index" do
    get machines_url
    assert_response 302
  end
end