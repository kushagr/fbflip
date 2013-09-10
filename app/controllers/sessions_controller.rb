class SessionsController < ApplicationController

	def create
		if params[:signed_request]
			@signed_request = signed_request
			puts @signed_request.to_s
			logger.info @signed_request.to_s
			logger.info @signed_request
			user = User.from_facebook(@signed_request)
			session[:current_user] = user.id
			# binding.pry
			redirect_to searches_index_path
		else
			# @facebook_cookies = facebook_cookies
			# user = User.from_facebook(@facebook_cookies)
			# session[:current_user] = user.id
			# # binding.pry
			 #redirect_to searches_index_path
		end
	end
end