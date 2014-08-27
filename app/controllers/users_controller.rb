class UsersController < ApplicationController
  before_action :login_only_once, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notices] ||= [] << "Success!"
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def login_only_once
    # logged in? go to cats index.
    redirect_to cats_url if logged_in? 
  end
  
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  
end
