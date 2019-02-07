class UsersController < ApplicationController

before_action :redirect_cancel, only: [:update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    flash[:previous_page] = request.referer
  end

  def create
    @user = User.create!(create_params)
    if @user
      session[:user_id] = @user.id
      redirect_to request.referer, notice: I18n.t("messages.logged_in_as") + " #{@user.name}!"
    else
      redirect_to request.referer, notice: I18n.t("messages.signup_failed")
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(update_params)
    if @user.save
      redirect_to user_path(current_user), notice: I18n.t("messages.profile_updated")
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
