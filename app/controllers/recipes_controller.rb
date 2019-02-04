class RecipesController < ApplicationController


  before_action :select_recipe, except: [:index, :new, :create, :search]
  before_action :set_up_new, only: [:new, :create]
  before_action :categories_recipes, only: [:index, :new, :create, :edit, :update, :search]
  before_action :set_up_user_recipes, only: [:index]
  before_action :redirect_cancel, only: [:create, :update]

  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screencapture.js')

  def index
  end

  def new
  end

  def show
    @comments = @recipe.comments
    @comment = Comment.new
    if @recipe.visits.nil?
      new_views = 0
    else
      new_views = @recipe.visits +=1
    end
    @recipe.update_attribute "visits", new_views
  end

  def create
    @recipe.user_id = session[:user_id]
    @category = Category.find_by(id: params[:category_id])
    @recipe.name = params[:recipe][:name]
    @recipe.complexity = params[:complexity]
    @recipe.category_id = params[:category_id]
    @recipe.prep_time = params[:recipe][:prep_time]
    @recipe.servings = params[:recipe][:servings]
    @recipe.ingredients = params[:recipe][:ingredients]
    @recipe.directions = params[:recipe][:directions]

    if params[:recipe][:photos] #this param is an object
      @recip.photos.attach(params[:recipe][:photos])
    end

    if params[:recipe][:screencapture] != "" #this param is a string
      if params[:recipe][:screencapture_name] == "" #this param is a string
        screencapture_name = "Screencapture"
      else
        screencapture_name = params[:recipe][:screencapture_name].gsub(" ", "_")
      end
      #Set up path to save the captured image
      Dir.chdir(Rails.root.join("#{Rails.root}","app","assets", "images"))
      #run phantomjs
      system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params["recipe"]["screencapture"]} #{screencapture_name}.png"
      #attaching file from app/assets/images
      @recipe.screencapture.attach(
        io: File.open(Rails.root.join("#{Rails.root}","app","assets", "images", "#{screencapture_name}.png")),
        filename: "#{screencapture_name}.png",
        content_type: "image/png")
    end

    if @recipe.save
      # flash[:notice] = "Recipe added!"
      redirect_to recipe_path(@recipe), info: "Recipe added !"
    else
      # puts @recipe.errors.full_messages
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
    @recipe.prep_time = params[:recipe][:prep_time]
    @recipe.servings = params[:recipe][:servings]
    @recipe.ingredients = params[:recipe][:ingredients]
    @recipe.directions = params[:recipe][:directions]

    if params[:recipe][:photos] #this param is an object
      @recipe.photos.attach(params[:recipe][:photos])
    end

    if params[:recipe][:remove_photos] == "1"
      @recipe.photos.purge_later
    end

    if params[:recipe][:screencapture] != "" #this param is a string
      if params[:recipe][:screencapture_name] == "" #this param is a string
        screencapture_name = "Screencapture"
      else
        screencapture_name = params[:recipe][:screencapture_name].gsub(" ", "_")
      end
      #Set up path to save the captured image
      Dir.chdir(Rails.root.join("#{Rails.root}","app","assets", "images"))
      #run phantomjs
      system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params["recipe"]["screencapture"]} #{screencapture_name}.png"
      #attaching file from app/assets/images
      @recipe.screencapture.attach(
        io: File.open(Rails.root.join("#{Rails.root}","app","assets", "images", "#{screencapture_name}.png")),
        filename: "#{screencapture_name}.png",
        content_type: "image/png")
    end

      #webshot alternative, much slower and height needs to be set explicitly
      # @ws = Webshot::Screenshot.instance
      # @ws.capture "#{params["recipe"]["screencapture"]}", "#{params["recipe"]["screencapture_name"]}.png", width: 1024, height: 30000

    if params[:recipe][:remove_screencapture_saved_locally] == "1"
      File.delete(Rails.root.join("#{Rails.root}","app","assets", "images", "#{@recipe.screencapture.filename.base}.png"))
    end

    if params[:recipe][:remove_screencapture] == "1"
      @recipe.screencapture.purge_later
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
      if @recipes.count == 1
        flash.now[:notice] = "This search returned #{@recipes.count} recipe."
      elsif @recipes.count != 1
        flash.now[:notice] = "This search returned #{@recipes.count} recipes."
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

  def redirect_cancel
    redirect_to recipe_path(@recipe) if params[:cancel]
  end

end
