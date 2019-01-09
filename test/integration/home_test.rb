require 'test_helper'

# 主页的继承测试
class HomeTest < ActionDispatch::IntegrationTest
  # 测试欢迎页
  test "can see the welcome page" do
    get "/"
    assert 200
  end
end
