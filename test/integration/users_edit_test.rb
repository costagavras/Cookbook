require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should successfully edit user" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "Swincus",
                                              password: "123",
                                              password_confirmation: "123" } }
                                     
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

end
