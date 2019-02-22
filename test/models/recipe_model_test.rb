require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(name: "Pincus", password: "Swincus",
      password_confirmation: "Swincus")
    @category = Category.create!(name: "Soups")
    @recipe = @user.recipes.create!(name: "Pizza", prep_time: 1, complexity: 1, ingredients: "Five",
    directions: "Do this and that", servings: 2, visits: 0, user: @user, category: @category)
    @recipe2 = @user.recipes.create!(name: "Pizza", prep_time: 1, complexity: 1, ingredients: "Five",
    directions: "Do this and that", servings: 2, visits: 5, user: @user, category: @category)
    @comment = @recipe.comments.create!(description: "Great!", user: @user)
  end

  test "recipe order should be most viewed first" do
    assert_equal @recipe2, Recipe.most_viewed.first
  end

  test "recipe user id should be present" do
    @recipe.user_id = nil
    refute @recipe.valid?
  end

  test "recipe category id should be present" do
    @recipe.category_id = nil
    refute @recipe.valid?
  end

  test "recipe servings should be from 1 to 20" do
    @recipe.servings = 22
    refute @recipe.valid?
  end

  #factories

  test "factory recipe must be valid" do
    recipe = build(:recipe)
    assert recipe.valid?
  end


end
