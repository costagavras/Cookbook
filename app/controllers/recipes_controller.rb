class RecipesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new

  end

  def show

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

  def select_hunt
    @recipe = Recipe.find(params[:id])
  end

  def categories_hunts
    @categories = Category.all
  end


end
