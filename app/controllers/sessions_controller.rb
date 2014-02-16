class SessionsController < ApplicationController
  
  def initialize
    
  end

  def login   
    api = UserApp::API.new
    oauth_result = api.oauth.get_authorization_url(provider_id: "facebook", redirect_uri: "http://localhost:3000/auth_step", scopes: ["read_friendlists", "read_stream", "read_insights"])
    redirect_to oauth_result.authorization_url
  end

  def auth_step

    begin
        userapp_token = params[:ua_token]   
        api = UserApp::API.new(token: userapp_token)
        user_result=api.user.get(user_id: "self")
        session[:userapp_id] = user_result[0].user_id
        session[:userapp_token] = userapp_token
        binding.pry
        redirect_to root_url
    rescue UserApp::ServiceError => error
        redirect_to user_behaviors_path

    end
  end


end
