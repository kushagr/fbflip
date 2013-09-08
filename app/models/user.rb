class User < ActiveRecord::Base

	def self.from_facebook(cookie)
		user = find_or_initialize_by(:fb_uid =>cookie["user_id"]) 
		user.access_token = cookie['access_token']
		user.save!
		return user
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(access_token)		
	    block_given? ? yield(@facebook) : @facebook
	  	rescue Koala::Facebook::APIError => e
	    logger.info e.to_s
	    nil
	end

	def college
		@education = facebook.get_object('me') { |data| data['education'] }
		@college = @education.find {|schools| schools['type'] == 'College'}
		return @college
	end

	def college_friends
		@college = college
		@friends = get_friends_with_education.shuffle
		@college_friends = []
		@friends.each do |friend| 
			friend.each do |education|
				if education['type'].present? && education['type'] == 'College' 
					binding.pry
					@college_friends << education.find_all do |college| 
						college["school"]["id"]== @college["school"]["id"] || college["school"]["name"] == @college["school"]["name"] 
					end
				
			 	# break if @college_friends.size == 8 
				else
					@non_college_friends << friend
				end
			end

		end
	end

	# def get_college_friend

	# end

	# 		unless friend["education"]['type'].present?	
	# 		 	college = friend["education"].find {|schools| schools['type'] == 'College'}
	# 		 	next if college.nil?
	# 		 	if college["school"]["id"] == @college["school"]["id"] || college["school"]["name"] == @college["school"]["name"]
	# 				@college_friends << { id: friend["id"],
	# 									name: friend["name"],
	# 									picture: friend["picture"]["data"]["url"],
	# 									}
	# 			end
	# 		 	break if @college_friends.size == 8 
	# 		end
	# 	end
	# 	return @college_friends
	# end

	def non_college_friends

		@college = college
		@friends = get_friends_with_education.shuffle
		@random_friends = []
		@friends.each do |friend| 
			unless friend["education"].present?	
			 	college = friend["education"].find {|schools| schools['type'] == 'College'}
			 	next if college.nil?
			 	if college["school"]["id"] != @college["school"]["id"] || college["school"]["name"] != @college["school"]["name"]
					@random_friends << { id: friend["id"],
										name: friend["name"],
										picture: friend["picture"]["data"]["url"],
										}
			 	end
			 	break if @random_friends.size == 3
			end
		end
		return @random_friends
	end

	def get_friends_with_education
		@friends = facebook.get_connection("me","friends?fields=education,id,name,picture.width(50).height(50)")
		# @friends = @friends.delete_if { |friend| !friend["education"].present? }
		# @friends.each do |friend|
		#   friend['education'].delete_if { |school| school["type"] != "College" }
		# end
		# @friends = @friends.delete_if { |friend| friend["education"].empty? }
	end

end