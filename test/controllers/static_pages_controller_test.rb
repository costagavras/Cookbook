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
  #   post recipe_search_url
  #   assert_response :success
  #   assert_select "title", "Cookbook"
  # end

  # test "should show filter result" do
  #   get recipe_filter
  #   assert_response :success
  #   assert_select "title", "Cookbook"
  # end


end
