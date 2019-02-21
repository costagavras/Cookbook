require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

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

  test "recipes associated to user should be destroyed" do
    assert_difference 'Recipe.count', -2 do
      @user.destroy
    end
  end

  test "should show recipes" do
    get recipes_path(@user)
    assert_response :success
  end

  test "should show edit" do
    get edit_recipe_path(@recipe)
    assert_response :success
  end

  # test "should create recipe" do
  #   assert_difference("Recipe.count") do
  #     post recipes_path, params: {recipe: {name: @recipe.name, prep_time: @recipe.prep_time, ingredients: @recipe.ingredients,
  #     directions: @recipe.directions, servings: @recipe.servings, visits: @recipe.visits, user: @recipe.user},
  #     category: @recipe.category, complexity: @recipe.complexity}
  #   end
  # end

end
