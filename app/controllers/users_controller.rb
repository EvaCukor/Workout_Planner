class UsersController < ApplicationController
  before_action :require_user, only: [:homepage, :exercises, :show]
  
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
    @user = User.find_by username: params[:username]
  end
  
  def exercises
    @users = User.paginate(:page => params[:page], :per_page => 5).order('LOWER(username) ASC')
    
    respond_to do |format|
      format.js { @exercises = Exercise.all.sort_by{ |x| x.name.downcase } }
      format.html  
    end
  end
  
  def workouts
    @users = User.paginate(:page => params[:page], :per_page => 5).order('LOWER(username) ASC')
    
    respond_to do |format|
      format.js { @workouts = Workout.all.sort_by{ |x| x.name.downcase } }
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
end