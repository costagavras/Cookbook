require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get welcome_index_url
    assert_response :success
  end

  # test "layout links" do
  #   get root_path
  #   user = create(:user)
  #   assert_template 'welcome/index'
  #   assert_select "a[href=?]", user_path(user)
  #   assert_select "a[href=?]", about_path
  #   assert_select "a[href=?]", recipes_path
  #   assert_select "a[href=?]", new_recipe_path
  #   assert_select "a[href=?]", recipe_search
  #   refute_select "a[href=?]", '/', count: 0
  # end

end
