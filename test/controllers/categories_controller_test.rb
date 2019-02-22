require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  test "should get category show" do
    category = create(:category)
    get category_path(category)
    assert_response :success
  end

end
