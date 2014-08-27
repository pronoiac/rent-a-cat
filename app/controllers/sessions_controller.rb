class SessionsController < ApplicationController
  before_action :login_only_once, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if @user.nil?
      @user = User.new(user_params)
      flash.now[:errors] ||= [] << "Credentials were wrong"
      render :new
    else
      session[:session_token] = @user.session_token
      flash[:notices] ||= [] << "Successfully logged in!"
      redirect_to cats_url
    end
  end
  
  def destroy
    logout!
    flash[:notices] ||= [] << "Successfully logged out!"
    redirect_to new_session_url
  end
  
  def login_only_once
    # logged in? go to index.
    redirect_to cats_url if logged_in? 
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
