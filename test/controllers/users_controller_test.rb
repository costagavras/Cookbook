require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

#functional tests using fixtures, tags to users.yml

  setup do
    @user = users(:one)
  end

  test "user show" do
    get user_path(@user)
    assert_response :success
  end

  # test "create user" do
  #   assert_difference("User.count") do
  #     post users_path, params: {user: {name: @user.name,
  #     password_digest: @user.password_digest}}
  #   end
  #
  #   assert_redirected_to user_path(User.last)
  #
  # end


end
