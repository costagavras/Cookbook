class SessionsController < ApplicationController

  def new
    @user = User.new
    flash[:previous_page] = request.referer
  end

  def create
    @user = User.new
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if flash[:previous_page] && flash[:previous_page] != :login
        redirect_to flash[:previous_page], info: I18n.t("messages.logged_in")
      else
        redirect_to request.referer, info: I18n.t("messages.logged_in_as") + " #{@user.name}!"
      end

    else
      # flash[:notice] = "Login Failed"
      redirect_to request.referer, info: I18n.t("messages.login_failed")
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, info: I18n.t("messages.logged_out")
  end

end
