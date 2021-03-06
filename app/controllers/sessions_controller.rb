class SessionsController < ApplicationController
  def new
    #Loginform
  end
  def fb_login_attempt
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to games_path
  end

  def login_attempt
    user = User.find_by(:username => params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back!"
      redirect_to games_path
    else
      flash[:notice] = "Invalid login. Please try again."
      redirect_to login_path
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

end
