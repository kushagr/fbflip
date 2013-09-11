class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  private

  def signed_request
    @signed_request = Koala::Facebook::OAuth.new.parse_signed_request(params[:signed_request])    
  end


  def current_user
    begin
      @current_user ||= User.find(session[:current_user]) if session[:current_user]
    rescue
      session[:current_user] = nil
    end
  end

  helper_method  :signed_request,:current_user
end
