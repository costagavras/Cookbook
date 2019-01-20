class RecipesController < ApplicationController





  def index
    @categories = Category.all
  end

  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  def show
    @comments = @recipe.comments
    @comment = Comment.new
  end

  def create


  end

  def edit


  end

  def update


  end

  def destroy


  end

  def search

  end

  private

  def set_up_new
    @recipe = Recipe.new
  end

  def select_recipe
    @recipe = Recipe.find(params[:id])
  end

  def categories_recipes
    @categories = Category.all
  end


end
