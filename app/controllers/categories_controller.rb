class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @user_recipes = @category.recipes.where(user_id: current_user)
  end

end
