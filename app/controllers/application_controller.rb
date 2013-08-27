class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :authenticate

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private
  def authenticate
    if !current_user
      flash[:error] = "You must be logged in to access this section of the site"
      redirect_to sign_in_path
    end
  end

end
