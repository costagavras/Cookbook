require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  test "should get new comment" do
    category = create(:category)
    assert category.valid?
    user = create(:user, name: "Picciu2")
    assert user.valid?
    recipe = create(:recipe, user: user, category: category)
    assert recipe.valid?
    comment = build(:comment, recipe: recipe, user: user)
    assert comment.valid?
    get new_recipe_comment_url(recipe)
    # post recipe_comments_url(recipe)
    # assert_response :success
  end
  #
  # test "should get create" do
  #   get comment_create_url
  #   assert_response :success
  # end

end
