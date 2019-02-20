require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

#functional tests using fixtures, tags to users.yml

  def setup
    @user = users(:one)
  end

  test "should show user" do
    get user_path(@user)
    assert_response :success
  end

  # no view new.html.erb exists
  # test "should get new" do
  #   get new_user_path
  #   assert_not_response :success
  # end

  test "should create user" do
    assert_difference("User.count") do
      post users_path, params: {user: {name: "Vanico",
      password: "hello", password_confirmation: "hello"}}
    end
  end

  test "should not create user" do
    assert_no_difference("User.count") do
      post users_path, params: {user: {name: "Vanico",
      password: "hello", password_confirmation: "ciao"}}
    end
  end

  test "should see edit user" do
    get edit_user_path(@user)
    assert_response :success
  end



end
