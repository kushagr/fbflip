class SessionsController < ApplicationController

	def create
		if params[:signed_request]
			user = User.from_facebook(signed_request)
			if (user)
				session[:current_user] = user.id
				redirect_to '/home/index'
			else
				session[:current_user] = nil
				redirect_to '/home/index'
			end
		end
	end

end
