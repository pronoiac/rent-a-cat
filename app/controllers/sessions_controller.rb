class SessionsController < ApplicationController
  before_action :login_only_once, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      render json: "Credentials were wrong"
    else
      session[:session_token] = user.session_token
      render json: "Welcome back #{user.user_name}!"
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
  
  def login_only_once
    # logged in? go to index.
    redirect_to cats_url if logged_in? 
  end
  
end
