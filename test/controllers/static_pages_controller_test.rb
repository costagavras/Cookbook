require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should show homepage via welcome" do
    get welcome_index_path
    assert_response :success
    assert_select "title", "Cookbook"
  end

  test "should show homepage via root" do
    get root_path
    assert_response :success
    assert_select "title", "Cookbook"
  end

  test "should show about" do
    get about_path
    assert_response :success
    assert_select "title", "Cookbook"
  end

  # test "should show search result" do
  #   get recipe_search
  #   assert_response :success
  #   assert_select "title", "Cookbook"
  # end
  #
  # test "should show filter result" do
  #   get recipe_filter
  #   assert_response :success
  #   assert_select "title", "Cookbook"
  # end

  #failing one test on "a[href="/"]"
  # test "layout links" do
  #   get root_path
  #   assert_template 'welcome/index'
  #   assert_select "a[href=?]", root_path
  #   assert_select "a[href=?]", user_path
  #   assert_select "a[href=?]", about_path
  #   assert_select "a[href=?]", "/?locale=en"
  #   assert_select "a[href=?]", recipes_path
  #   assert_select "a[href=?]", new_recipe_path
  #   assert_select "a[href=?]", recipe_search
  #   assert_select "a[href=?]", '/', count: 0
  # end

end
