require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

#functional tests using fixtures, tags to users.yml

  def setup
    @user = users(:one)
  end

  test "user show" do
    get user_path(@user)
    assert_response :success
  end

  test "create user" do
    assert_difference("User.count") do
      post users_path, params: {user: {name: "Vanico",
      password: "hello", password_confirmation: "hello"}}
    end
  end

  test "edit user" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "update user" do
    patch user_url(@user), params: {user: {name: "Giorgio",
    password: "123", password_confirmation: "123"}}
  end

  test "delete user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
  end


end
