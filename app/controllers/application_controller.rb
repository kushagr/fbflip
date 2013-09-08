class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  

  def parse_facebook_cookies
	 @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end

  helper_method :parse_facebook_cookies #, current_user
end
