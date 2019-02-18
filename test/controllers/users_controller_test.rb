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

  #no view new.html.erb exist
  # test "should get new" do
  #   get new_user_path
  #   assert_response :success
  # end

  test "should create user" do
    assert_difference("User.count") do
      post users_path, params: {user: {name: "Vanico",
      password: "hello", password_confirmation: "hello"}}
    end
  end

  test "should edit user" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {user: {name: "Giorgio",
    password: "123", password_confirmation: "123"}}
  end

  test "should delete user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
  end


end
