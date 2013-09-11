class HomeController < ApplicationController

	def index
		if params[:signed_request]
			user = User.from_facebook(signed_request)
			if (!user.fb_uid.nil? && !user.access_token.nil?)
				session[:current_user] = user.id
			else
				user.delete!
				session[:current_user] = nil
			end
		end
	end

end
