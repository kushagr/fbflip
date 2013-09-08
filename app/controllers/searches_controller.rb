class SearchesController < ApplicationController
  
 def index
  # 	@graph = Koala::Facebook::GraphAPI.new(@facebook_cookies['access_token'])
  # 	@user = @graph.get_object("me")
  # 	@education = @graph.get_object("me") { |data| data['education'] }
  # 	@college = @education.find {|schools| schools['type'] == 'College'}
  # 	@college_details = @graph.get_object(@college["school"]["id"])
  # 	#@people_who_like_college = @graph.get_connection(@college["school"]["id"],'likes')
  #   #get friends list
  #   @friendlists = @graph.get_connection("me","friends?fields=education,id")
  #   @friendlists = @friendlists.find_all { |friend| friend["education"].present? }
  #   @friendlists.each do |friend|
  #     friend['education'].keep_if { |school| school["type"] == "College" }
  #   end
  @facebook_cookies = parse_facebook_cookies
  @user = User.from_facebook(@facebook_cookies)
  # binding.pry
    # user = User.new
    #p user.college
    # p user.college_friends
    # p user.non_college_friends
  	# binding.pry
  end

end
