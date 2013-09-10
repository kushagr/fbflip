class SessionsController < ApplicationController

	def create
		if params[:signed_request]
			user = User.from_facebook(@signed_request)
			session[:current_user] = user.id
			# binding.pry
			redirect_to searches_index_path
		end
	end
end