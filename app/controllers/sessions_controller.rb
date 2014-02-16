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
        search_result = api.oauth.connection.search(user_id: session[:userapp_id], fields: "*")
        facebook_id=search_result.items[0].provider_user_id
        make_user(user_result, facebook_id)
        redirect_to root_url
    rescue UserApp::ServiceError => error
        redirect_to user_behaviors_path

    end
  end

private
  def make_user(user_result, facebook_id)
    userapp_id = user_result[0].user_id
    unless User.where(userapp_id: userapp_id).first
      first_name = user_result[0].first_name
      last_name = user_result[0].last_name
      email = user_result[0].email
      User.create(first_name: first_name, last_name: last_name, email: email, userapp_id: userapp_id)
      user_id = User.where(userapp_id: userapp_id).first.id
      Page.create(facebook_id: facebook_id, user_id: user_id)
    end 

  end


end
