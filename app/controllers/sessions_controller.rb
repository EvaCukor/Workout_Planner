class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user.username)
    end
  end
  
  def create    
    @user = User.find_by username: params[:username]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.username)
    else
      flash[:error] = "There is something wrong with your username or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:exercise_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to login_path
  end
end