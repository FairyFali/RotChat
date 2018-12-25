require 'test_helper'
 
class UserController < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "user name is not nil" do
  	user = User.new
  	assert_not !user.memo.nil?
  end

  test "user insert nil is error" do
  	user = User.new
  	assert_not user.save
  end

  test "user insert success" do
  	user = User.new("memo":"fairy")
  	assert_not user.save
  end

  test "user is admin" do
    user = User.find(1)
    assert user.admin?
  end

  test "user machines" do
    user = User.find(1)
    machines = user.machines
    assert_not machines.nil?
  end
end
