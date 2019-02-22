require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should login" do
    get root_path
    user = create(:user)
    assert_template 'welcome/index'
    assert_template "sessions/_form"
    post sessions_path, params: {name: user.name, password: user.password}
    assert_redirected_to root_url(locale: :en)
    assert_equal "Logged in as " + user.name + "!", flash[:info]
  end

  test "should log out" do
    user = create(:user)
    post sessions_path, params: {name: user.name, password: user.password}
    assert_equal "Logged in as " + user.name + "!", flash[:info]
    delete session_path(user)
    assert_redirected_to root_url(locale: :en)
    assert_equal "Logged out", flash[:info]
  end


end
