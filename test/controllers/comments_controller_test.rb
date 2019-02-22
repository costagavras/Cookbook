require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  test "should create new comment" do
    category = create(:category)
    assert category.valid?
    user = create(:user, name: "Picciu2")
    assert user.valid?
    recipe = create(:recipe, user: user, category: category)
    assert recipe.valid?
    comment = create(:comment, description: "nice", recipe: recipe, user: user)
    assert comment.valid?
    get recipe_url(recipe)
    assert_response :success
    assert_select 'p', {text: "nice", count: 1}
  end

end
