require 'test_helper'

class RecipesIntegrationTest < ActionDispatch::IntegrationTest

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

    # test "should successfully edit recipe" do
    #   get edit_recipe_path(@recipe)
    #   assert_template 'recipes/edit'
    #
    #   patch recipe_path(@recipe), params: { recipe: { name: "Pasta" } }
    #   assert_redirected_to @recipe
    #
    #   @recipe.reload
    #   assert_equal "Pasta", @recipe.name
    #
    #   assert_equal "Recipe successfully updated", flash[:notice]
    # end
    #
    # test "should fail to edit recipe" do
    #   get edit_recipe_path(@recipe)
    #   assert_template 'recipes/edit'
    #   patch recipe_path(@recipe), params: { recipe: { name: "" } }
    #   assert_equal "Name can't be blank", flash[:alert]
    #   assert_template 'recipes/show'
    # end

end
