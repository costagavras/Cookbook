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

  def most_viewed_recipes
      current_user.recipes.most_viewed[0..9]
  end

  helper_method :current_user
  helper_method :sign_up
  helper_method :most_viewed_recipes
end
