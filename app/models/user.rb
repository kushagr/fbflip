class User < ActiveRecord::Base

	def self.from_facebook(signed_request)
		unless signed_request["user_id"].nil?
			user = find_or_initialize_by(:fb_uid =>signed_request["user_id"]) 
			# get long-lived exchange token immidiately.
			# long_lived_access_token = Koala::Facebook::OAuth.new.exchange_access_token(signed_request['oauth_token'])
			user.access_token = signed_request['oauth_token']
			user.save!
			return user
		end
		return nil
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
		 	college = friend["education"].find {|schools| schools['type'] == 'College'}
		 	if college["school"]["id"] == @college["school"]["id"]   
				@college_friends << { id: friend["id"],
									name: friend["name"],
									}
			end		
			break if @college_friends.size == 8 
		end
		return @college_friends
	end

	def friends
		@college = college
		@friends = get_friends_with_education.shuffle
		@random_friends = []
		@friends.each do |friend| 
			 	college = friend["education"].find {|schools| schools['type'] == 'College'}
			 	if college["school"]["id"] != @college["school"]["id"]
					@random_friends << { id: friend["id"],
										name: friend["name"],
										}
			 	end
		 	break if @random_friends.size == 3
		end
		return @random_friends
	end

	def get_friends_with_education
		@friends = facebook.get_connection("me","friends?fields=education,id,name")
		@friends.keep_if do |friend|
			friend["education"].present? && friend["education"].any? do |school|
				school["type"] == "College"
			end 
		end
	end

end