class UsersController < ApplicationController

  before_action :categories_recipes, only: [:show]
  before_action :set_up_user_recipes, only: [:show]


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    flash[:previous_page] = request.referer
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      session[:user_id] = @user.id
      redirect_to request.referer, notice: "Logged in as #{@user.name}!"
    else
      redirect_to request.referer, notice: "Signup failed!"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to user_path(current_user), notice: "Profile successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

  private

  def set_up_user_recipes
    @user_recipes = Recipe.where(user_id: current_user)
    @user_categories = []
    @user_recipes.each do |recipe|
      if @categories.include?(recipe.category)
        @user_categories << recipe.category
      end
    end
    @user_categories = @user_categories.uniq
  end

  def categories_recipes
    @categories = Category.all
  end

end
