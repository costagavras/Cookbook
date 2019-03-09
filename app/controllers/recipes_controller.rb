class RecipesController < ApplicationController

  before_action :select_recipe, except: [:index, :new, :create, :filter, :search]
  before_action :set_up_new, only: [:new, :create]
  before_action :categories_recipes, only: [:index, :new, :create, :edit, :update, :filter, :search]
  before_action :set_up_user_recipes, only: [:index, :filter]
  before_action :redirect_cancel, only: [:create, :update]

  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screencapture.js')

  def index
  end

  def new
  end

  def show
    @comments = @recipe.comments
    @comment = Comment.new
    @recipe.visits.nil? ? new_views = 0 : new_views = @recipe.visits +=1
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
      @recipe.photos.attach(params[:recipe][:photos])
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
      #attaching file from app/assets/images/screencapture_name.png
      @recipe.screencapture.attach(
        io: File.open(Rails.root.join("#{Rails.root}","app","assets", "images", "#{screencapture_name}.png")),
        filename: "#{screencapture_name}.png",
        content_type: "image/png")
    end

    if @recipe.save
      redirect_to recipe_path(@recipe), info: I18n.t("recipe.added")
    else
      # puts @recipe.errors.full_messages
      params[:recipe] = nil
      render :new
      flash[:alert] = I18n.t("recipe.not_added")
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
      # Dir.chdir(Rails.root.join("#{Rails.root}","app","assets", "images"))
      Dir.chdir(Rails.root.join("#{Rails.root}", "assets", "images"))
      #run phantomjs
      system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params["recipe"]["screencapture"]} #{screencapture_name}.png"
      #attaching file from app/assets/images/screencapture_name.png
      @recipe.screencapture.attach(
        # io: File.open(Rails.root.join("#{Rails.root}","app","assets", "images", "#{screencapture_name}.png")),
        io: File.open(Rails.root.join("#{Rails.root}", "assets", "images", "#{screencapture_name}.png")),
        filename: "#{screencapture_name}.png",
        content_type: "image/png")
      if @recipe.screencapture.attached?
        # File.delete(Rails.root.join("#{Rails.root}","app","assets", "images", "#{@recipe.screencapture.filename.base}.png"))
        File.delete(Rails.root.join("#{Rails.root}", "assets", "images", "#{@recipe.screencapture.filename.base}.png"))
      end
    end

      #webshot alternative, much slower and height needs to be set explicitly
      # @ws = Webshot::Screenshot.instance
      # @ws.capture "#{params["recipe"]["screencapture"]}", "#{params["recipe"]["screencapture_name"]}.png", width: 1024, height: 30000

    # if params[:recipe][:remove_screencapture_saved_locally] == "1"
    #   File.delete(Rails.root.join("#{Rails.root}","app","assets", "images", "#{@recipe.screencapture.filename.base}.png"))
    # end

    if params[:recipe][:remove_screencapture] == "1"
      @recipe.screencapture.purge_later
    end

    if @recipe.save
      redirect_to recipe_path(@recipe), info: I18n.t("recipe.updated")
    else
      @recipe.errors.full_messages
      params[:recipe] = nil
      render :edit
      flash[:alert] = I18n.t("recipe.not_updated")
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, info: I18n.t("recipe.deleted")
    else
      redirect_to recipes_path, info: I18n.t("recipe.not_deleted")
    end

  end

  def filter
    if filtering_params_exist?
      if params[:condition] != nil
        if params[:condition] == "or"
          @filtered_recipes = []
          filtering_params(params).each do |key, value|
            #needs to be transofrmed to an array if not it's an ActiveRecord::Relation instance)
            @filtered_recipes << @user_recipes.public_send(key, value).to_a if value.present?
          end
        elsif params[:condition] == "and"
          @user_recipes_temp = @user_recipes
          filtering_params(params).each do |key, value|
            @filtered_recipes = @user_recipes.public_send(key, value) if value.present?
            @user_recipes = @filtered_recipes if @filtered_recipes != nil
            #check necessary to avoir @filtered_recipes becoming nil if first (key,value) return nil result
          end
          @filtered_recipes = @user_recipes.to_a
          @user_recipes = @user_recipes_temp
        end
        #needs to be flattened if not it remains a double array (after .to_a)
        @filtered_recipes.flatten!
        #for some reason it doubles some values in the array
        @filtered_recipes = @filtered_recipes.uniq
        if @filtered_recipes.empty?
          @filtered_result = false
          @filter_result_message = I18n.t("filter.returns_0")
        elsif !@filtered_recipes.empty? && @filtered_recipes.count == @user_recipes.count
          @filtered_result = false
          @filter_result_message = I18n.t("filter.returns_all")
        else
          @filtered_result = true
          @filter_result_message = I18n.t("recipe.search_found") + " #{@filtered_recipes.count}"
          @filtered_categories = []
          @filtered_recipes.each do |recipe|
            if @categories.include?(recipe.category)
              @filtered_categories << recipe.category
            end
          end
          @filtered_categories = @filtered_categories.uniq
          filter_conditions_message(params[:condition])
        end
      else
        @filter_result_message = I18n.t("filter.choose_condition")
      end
    # else
    #   @filter_result_message = "I did not run!!!!"
    end
  end

  def search
    if params[:recipe]
      @recipes = Recipe.where(user_id: current_user)
      @user_recipes = @recipes.where("name like ?", "%#{params[:recipe]}%")
      @user_categories = []
      @user_recipes.each do |recipe|
        if @categories.include?(recipe.category)
          @user_categories << recipe.category
        end
      end
      @user_categories = @user_categories.uniq
      if @user_recipes.count > 0
        flash.now[:notice] = I18n.t("recipe.search_found") + " #{@user_recipes.count}"
      elsif @user_recipes.count == 0
        flash.now[:notice] = I18n.t("recipe.search_not_found")
      elsif params[:recipe] == ""
        flash.now[:notice] = I18n.t("recipe.search_all")
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
    @recipe = Recipe.new(name: "my new recipe", prep_time: 30, servings: 6, complexity: 1, ingredients: "love", directions: "hard work")
  end

  def select_recipe
    @recipe = Recipe.find(params[:id])
  end

  def categories_recipes
    @categories = Category.all
  end

  def redirect_cancel
    if params[:cancel]
      if @recipe.valid?
        redirect_to recipe_path(@recipe) and return
      else
        redirect_to recipes_path and return
      end
    end
  end

  # A list of the param names that can be used for filtering the recipe list
  def filtering_params(params)
    params.slice(:prep_time_shorter_than, :prep_time_equal_to, :prep_time_longer_than,
      :difficulty_less_than, :difficulty_equal_to, :difficulty_more_than)
  end

  def filtering_params_exist?
    filtering_params(params).each do |key, value|
       if value.present?
         return true
       end
    end
    return false
  end

  def filter_conditions_message(condition)
    message1 = ""
    message2 = ""
    filtering_params(params).each do |key, value|
       if value.present?
         message1 = key + ": " + value + "\n" + condition.upcase + "\n"
         message2 = message2 + message1
       end
    end
    @filter_conditions_message = message2[0..message2.rindex(/\n/,-2)]
  end

end
