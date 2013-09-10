class SessionsController < ApplicationController

	def create
		@facebook_cookies = facebook_cookies
		user = User.from_facebook(@facebook_cookies)
		session[:current_user] = user.id
		# binding.pry
		redirect_to searches_index_path
	end
end