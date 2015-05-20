class WorkoutsController < ApplicationController
  before_action :require_user
  
  def new
    @workout = Workout.new    
    #@categories = Category.all.sort_by{ |x| x.name.downcase }
    #@exercises = Exercise.all.sort_by{ |x| x.name.downcase }
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
      @workout = Workout.find_by(slug: params[:id])
      session[:prev_url] = request.referer
      format.js
      #format.html   
    end
  end
  
  def edit
    @workout = Workout.find_by(slug: params[:id])
    @categories = Category.all.sort_by{ |x| x.name.downcase }
    @exercises = Exercise.all.sort_by{ |x| x.name.downcase }
    session[:prev_url] = request.referer
  end
  
  def update
    @workout = Workout.find_by(slug: params[:id])
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
    @workout = Workout.find_by(slug: params[:id])  
    
    if params[:commit] == "Cancel"
      redirect_to session[:prev_url]
    else
      respond_to do |format|
        @workout.destroy
        format.js { @workouts = Workout.all.sort_by{ |x| x.total_votes }.reverse }
        format.html { redirect_to session[:prev_url] }        
      end
    end
  end
  
  def vote
    @workout = Workout.find_by(slug: params[:id])
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
end