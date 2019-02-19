require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "Swincus",
                                              password: "123",
                                              password_confirmation: "123" } }

    assert_template 'users/show'
  end
end
