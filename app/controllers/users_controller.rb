class UsersController < ApplicationController
  def index
     
  end

  def show
  end
  def login
    api = UserApp::API.new
    api.oauth.get_authorization_url(provider_id: "facebook", redirect_uri: "http://localhost:3000/", scopes: ["first_name"])
  end
end
