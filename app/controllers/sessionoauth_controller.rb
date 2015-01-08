class SessionoauthController < ApplicationController
  skip_before_filter :authorize
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
        User.create_with_omniauth(auth)
    session[:user_id] = user.id if user
    redirect_to users_path
  end
  
end
