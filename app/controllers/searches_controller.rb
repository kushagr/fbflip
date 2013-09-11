class SearchesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def index
    if current_user
      p current_user
      @user = current_user
    else
      p current_user
      @user = nil
    end
  end

end
