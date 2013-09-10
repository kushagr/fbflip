class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def facebook_cookies
   @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end

  def current_user
    @current_user ||= User.find(session[:current_user]) if session[:current_user]
  end
  

  

  helper_method :facebook_cookies, :current_user
end
