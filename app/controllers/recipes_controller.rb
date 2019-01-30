# require 'webshot'
# require 'phantomjs'
# require 'screencap'

class RecipesController < ApplicationController


  before_action :select_recipe, except: [:index, :new, :create, :search]
  before_action :set_up_new, only: [:new, :create]
  before_action :categories_recipes, only: [:index, :new, :create, :edit, :update, :search]
  before_action :set_up_user_recipes, only: [:index]

  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screencapture.js')

  def index
  end

  def new
  end

  def show
    @comments = @recipe.comments
    @comment = Comment.new
  end

  def create
    @recipe.user_id = session[:user_id]
    @category = Category.find_by(id: params[:category_id])
    @recipe.name = params[:recipe][:name]
    @recipe.complexity = params[:complexity]
    @recipe.category_id = params[:category_id]
    @recipe.grabbed = params[:grabbed]
    @recipe.prep_time = params[:recipe][:prep_time]
    @recipe.servings = params[:recipe][:servings]
    @recipe.ingredients = params[:recipe][:ingredients]
    @recipe.directions = params[:recipe][:directions]
    @recipe.photos.attach(params[:recipe][:photos])

    if @recipe.save
      # flash[:notice] = "Recipe added!"
      redirect_to recipe_path(@recipe), info: "Recipe added !"
    else
      # puts @hunt.errors.full_messages
      params[:recipe] = nil
      render :new
    end
  end

  def edit
    @category = Category.find_by(id: params[:category_id])
  end

  def update
    @recipe.user_id = session[:user_id]
    @category = Category.find_by(id: params[:category_id])
    @recipe.name = params[:recipe][:name]
    @recipe.complexity = params[:complexity]
    @recipe.category_id = params[:category_id]
    @recipe.grabbed = params[:grabbed]
    @recipe.prep_time = params[:recipe][:prep_time]
    @recipe.servings = params[:recipe][:servings]
    @recipe.ingredients = params[:recipe][:ingredients]
    @recipe.directions = params[:recipe][:directions]
    if params[:recipe][:photos]
      # puts "Hello, I'm before attach!"
      @recipe.photos.attach(params[:recipe][:photos])
      # puts "Hello, I'm after attach!"
    end
    # puts "Hello, I'm before purge!"
    if params[:recipe][:remove_photos] == "1"
      @recipe.photos.purge_later
      # puts "Hello, I'm after purge!"
    end
    if params[:recipe][:screencapture_name] != ""
      puts "Hello, I'm before screencapture!"
      Dir.chdir(Rails.root.join("#{Rails.root}","app","assets", "images"))
      system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params["recipe"]["screencapture"]} #{params["recipe"]["screencapture_name"]}.png"
      # @ws = Webshot::Screenshot.instance
      # @ws.capture "#{params["recipe"]["screencapture"]}", "#{params["recipe"]["screencapture_name"]}.png", width: 1024, height: 30000
      # f = Screencap::Fetcher.new("#{params["recipe"]["screencapture"]}")
      # screenshot = f.fetch(
      	# :output => "~/#{params["recipe"]["screencapture_name"]}.png", # don't forget the extension!
      	# optional:
      	# :div => '.header', # selector for a specific element to take screenshot of
      	# :width => 1024,
        # :height => 768,
      	# :top => 0, :left => 0, :width => 100, :height => 100 # dimensions for a specific area
      # )

      puts "Hello, I'm after screencapture!"
    end
    if @recipe.save
      # flash[:notice] = "Recipe updated!"
      redirect_to recipe_path(@recipe), info: "Recipe updated!"
    else
      puts @recipe.errors.full_messages
      params[:recipe] = nil
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    if @recipe.destroy
      # flash[:notice] = "Hunt deleted!"
      redirect_to recipes_path, info: "Recipe deleted!"
    end

  end

  def search
    if params[:recipe]
      @user_recipes = Recipe.where(user_id: current_user)
      @recipes = @user_recipes.where("name like ?", "%#{params[:recipe]}%")
      @user_categories = []
      @recipes.each do |recipe|
        if @categories.include?(recipe.category)
          @user_categories << recipe.category
        end
      end
      @user_categories = @user_categories.uniq
      if @recipes.count >= 0
        flash.now[:notice] = "This search returned #{@recipes.count} recipe(s)."
      elsif params[:recipe] == ""
        flash.now[:notice] = "This search returned all recipes!"
      end
    end
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
