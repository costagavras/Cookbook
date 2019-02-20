require 'test_helper'

class CommentTest < ActiveSupport::TestCase


  def setup
    @user = User.create!(name: "Pincus", password: "Swincus",
      password_confirmation: "Swincus")
    @category = Category.create!(name: "Soups")
    @recipe = @user.recipes.create!(name: "Pizza", prep_time: 1, complexity: 1, ingredients: "Five",
    directions: "Do this and that", servings: 2, visits: 0, user: @user, category: @category)
    @comment = @recipe.comments.create!(description: "Great!", user: @user)
  end

  test "comment should be valid" do
    assert @user.valid?
    assert @recipe.valid?
    assert @comment.valid?
  end

  test "comment user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

end
