class UsersController < ApplicationController

before_action :redirect_cancel, only: [:update]
before_action :find_user, only: [:show, :edit, :update, :destroy ]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_back(fallback_location: @user)
      flash[:notice] = I18n.t("messages.logged_in_as") + " #{@user.name}!"
    else
      redirect_back(fallback_location: root_url)
      flash[:alert] = (I18n.t("messages.sign_up_failed") + ". " + I18n.t("messages.validate_input"))
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(update_params)
      redirect_to user_path(@user), notice: I18n.t("messages.profile_updated")
    else
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    @user = User.find(params[:id])
    @user.destroy
    flash[:info] = I18n.t("user.deleted")
    redirect_to root_url
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def create_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def redirect_cancel #only for the update form (new form closes via js)
    begin
      raise redirect_to user_path(@user) if params[:cancel] #if cancelled on a form not saved
    rescue
      redirect_to user_path
      # redirect_back(fallback_location: recipes_path)
    end
  end


end
