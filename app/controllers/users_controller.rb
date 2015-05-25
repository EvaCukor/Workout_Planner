class UsersController < ApplicationController
  before_action :require_user, only: [:homepage, :exercises, :show]
  before_action :set_paginated_users, only: [:exercises, :workouts]
  
  def new
    if logged_in?
      redirect_to user_homepage_path(current_user.username)
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_homepage_path(@user.username)
    else
      flash[:errors] = @user.errors.messages    
      redirect_to root_path
    end
  end
  
  def homepage
    @user = User.find_by(username: params[:username])
  end
  
  def exercises    
    respond_to do |format|
      format.js { @exercises = Exercise.all.sort_by{ |x| x.total_votes }.reverse }
      format.html  
    end
  end
  
  def workouts    
    respond_to do |format|
      format.js { @workouts = Workout.all.sort_by{ |x| x.total_votes }.reverse }
      format.html  
    end
  end
  
  def show
    @user = User.find_by(slug: params[:id])
    
    respond_to do |format|
      format.js
      format.html   
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit!
  end
  
  def set_paginated_users
    @users = User.paginate(:page => params[:page], :per_page => 5).order('LOWER(username) ASC')
  end
end