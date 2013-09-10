class HomeController < ApplicationController

	def index
		if params[:signed_request]
			@signed_request = signed_request
			puts @signed_request.to_s
			logger.info @signed_request.to_s
			logger.info @signed_request
			user = User.from_facebook(@signed_request)
			session[:current_user] = user.id
		end
	end

end
