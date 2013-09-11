class HomeController < ApplicationController

	def index
		if params[:signed_request]
			user = User.from_facebook(signed_request)
			session[:current_user] = user.id
		end
	end

end
