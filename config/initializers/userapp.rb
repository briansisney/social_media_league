options=UserApp::ClientOptions.get_global
  

options.app_id = ENV["USER_APP_ID"]

options.token = ENV["USER_APP_TOKEN"]
# api = UserApp::API.new(:app_id => "52ffabf2b0e09", :token => ENV["USER_APP_TOKEN"])
