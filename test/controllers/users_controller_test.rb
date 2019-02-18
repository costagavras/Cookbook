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
      post users_path, params: {user: {name: "Giorgio",
      password: "123", password_confirmation: "123"}}
    end

    assert_redirected_to user_path(User.last)

  end


end
