class WelcomeController < ApplicationController

  def index
    if session[:userapp_token]
      user = FacebookUser.new(session[:userapp_token])
      user.get_feed
      user.parse_data
    end
  end

end
