class SessionController < ApplicationController
  skip_before_filter :authorize, :set_i18n_locale_from_params
  def new
  end

  def create
  	if user = User.authenticate(params[:name], params[:password])
  		session[:user_id] = user.id
      session[:user_name] = user.name
  		redirect_to admin_url
  	else
  		redirect_to login_url, :alert => "Invalid user/password combination."
  	end
  end

    def create_with_oauth
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
          User.create_with_omniauth(auth)
      session[:user_id] = user.id if user
      session[:user_name] = user.name if user
      redirect_to users_path
    end

  def destroy
  	session[:user_id] = nil
    session[:user_name] = nil
  	redirect_to store_url, :notice => "Logged out"
  end
end
