class ApplicationController < ActionController::Base

before_action :set_locale
before_action :set_visit_history
add_flash_types :info #holds flash[:info] messages

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def require_login
    unless current_user
        flash[:alert] = I18n.t("messages.pls_log_in")
        redirect_to login_url
    end
  end

  def sign_up
    @user = User.new
  end

  def most_viewed_recipes
      current_user.recipes.most_viewed[0..9]
      # current_user.recipes.order(:visits).reverse_order[0..9]
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    cookies.permanent[:lang_locale] = locale
    @cookie_lang = locale
    # redirect_to request.referer || root_url
  end

  def default_url_options
    { locale: I18n.locale }
  end


  def set_visit_history

    if session[:cookbook]
      @trace = session[:cookbook]
    else
      @trace = Array.new
    end

    @trace.push(request.url)

    if @trace.count > 4
      @trace.shift
    end

    session[:cookbook] = @trace

  end

  helper_method :current_user
  helper_method :sign_up
  helper_method :most_viewed_recipes
end
