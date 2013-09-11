class SearchesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def index
    if current_user
      @user = current_user
    end
  end

end
