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

  test "should signup and log out" do
    user = create(:user)
    assert_difference("User.count") do
      post users_path, params: {user: {name: "Ostrica",
      password: user.password, password_confirmation: user.password_confirmation}}
      assert user.valid?
    end
    assert_equal "Logged in as Ostrica!", flash[:notice]
    delete session_path(user)
    assert_redirected_to root_url(locale: :en)
    assert_equal "Logged out", flash[:info]
  end

end
