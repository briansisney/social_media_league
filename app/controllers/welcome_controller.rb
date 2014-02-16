class WelcomeController < ApplicationController

  def index
    if session[:userapp_token]
      user = FacebookUser.new(session[:userapp_token])
      user.get_feed
    end
  end

end
