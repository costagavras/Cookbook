class ApplicationController < ActionController::Base


add_flash_types :info

  def current_user
    User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
        flash[:alert] = "Please log in"
        redirect_to login_url
    end
  end

  def sign_up
    @user = User.new
  end

  def first_most_viewed
      @seven_most_viewd = Recipe.most_viewed[0..6]
  end

  helper_method :current_user
  helper_method :sign_up
  helper_method :first_most_viewed

end
