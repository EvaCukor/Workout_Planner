class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  
  def new
    if logged_in?
      redirect_to user_path(current_user.username)
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.username)
    else
      flash[:errors] = @user.errors.messages    
      redirect_to root_path
    end
  end
  
  def show
    @user = User.find_by username: params[:username]
  end
  
  private
  
  def user_params
    params.require(:user).permit!
  end
end