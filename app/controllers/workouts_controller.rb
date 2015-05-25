class WorkoutsController < ApplicationController
  before_action :require_user
  before_action :set_workout, except: [:new, :create]
  before_action :checkboxes_categories, only: [:new, :create, :edit, :update]
  before_action :checkboxes_exercises, only: [:new, :create, :edit, :update]
  
  def new
    @workout = Workout.new
  end
  
  def create
    @workout = Workout.new(workout_params)
    @workout.creator = current_user
    
    if params[:commit] == "Cancel"
      redirect_to workouts_path
    elsif @workout.save
      flash[:notice] = "Workout created!"
      redirect_to workouts_path
    else
      render :new
    end
  end
  
  def show
    respond_to do |format|
      session[:prev_url] = request.referer
      format.js
      format.html   
    end
  end
  
  def edit
    session[:prev_url] = request.referer
  end
  
  def update
    if params[:commit] == "Cancel"
      redirect_to session[:prev_url]
    elsif @workout.update_attributes(workout_params)
      flash[:notice] = "The workout was updated."
      redirect_to session[:prev_url]
    else
      render :edit
    end
  end
  
  def destroy
    @workout.destroy
    redirect_to session[:prev_url]
  end
  
  def vote
    @vote = Vote.create(voteable: @workout, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        unless @vote.valid?
          flash[:error] = 'You can like or dislike an exercise only once.'
        end
        redirect_to session[:prev_url]
      end
      format.js
    end
  end
  
  private
  
  def workout_params
    params.require(:workout).permit!
  end
  
  def set_workout
    @workout = Workout.find_by(slug: params[:id])
  end
end