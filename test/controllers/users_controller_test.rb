require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

#functional tests using fixtures

  setup do
    @user = users(:one)
  end



  test "user show" do
    get user_path(@user)
    assert_response :success
  end

  test "create user" do
    assert_difference("User.count") do
      post users_path, params: {user: {name: @user.name,
      password: @user.password, password_confirmation: @user.password_confirmation}}
    end

    assert_redirected_to user_path(User.last)

  end


end
