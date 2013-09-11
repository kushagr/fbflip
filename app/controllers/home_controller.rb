class HomeController < ApplicationController

	def index
		if params[:signed_request]
			user = User.from_facebook(signed_request)
			if (user)
				session[:current_user] = user.id
			else
				session[:current_user] = nil
			end
		end
	end

end
