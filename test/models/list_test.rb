require 'test_helper'
 
class ListController < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "list name is not nil" do
  	list = List.new
  	assert_not !list.name.nil?
  end

  test "list insert nil is error" do
  	list = List.new
  	assert_not list.save
  end

  test "list insert success" do
  	list = List.new("name":"fairy")
  	assert list.save
  end
end
