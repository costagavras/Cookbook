require 'test_helper'

class UsersIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should successfully edit user" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "Swincus",
                                              password: "123",
                                              password_confirmation: "123" } }
    assert_redirected_to @user
    @user.reload
    assert_equal "Swincus", @user.name
    assert_equal "Profile successfully updated", flash[:notice]
  end

  test "should fail to edit user" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "  ",
                                              password: "123",
                                              password_confirmation: "123" } }

    assert_template 'users/edit'
  end

  test "should successfully delete user" do
    get edit_user_path(@user)
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to root_url(locale: :en)
  end

end
