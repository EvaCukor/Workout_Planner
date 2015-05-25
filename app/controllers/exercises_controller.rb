class ExercisesController < ApplicationController
  before_action :require_user
  before_action :set_exercise, except: [:new, :create]
  before_action :checkboxes_categories, only: [:new, :create, :edit, :update]
  before_action :checkboxes_equipment, only: [:new, :create, :edit, :update]
  before_action :checkboxes_body_parts, only: [:new, :create, :edit, :update]
  
  def new
    @exercise = Exercise.new
  end
  
  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.creator = current_user
    
    if params[:commit] == "Cancel"
      redirect_to exercises_path
    elsif @exercise.save
      flash[:notice] = "Exercise created!"
      redirect_to exercises_path
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
    elsif @exercise.update_attributes(exercise_params)
      flash[:notice] = "The exercise was updated."
      redirect_to session[:prev_url]
    else
      render :edit
    end
  end
  
  def destroy
    @exercise.destroy
    redirect_to session[:prev_url]
  end
  
  def vote
    @vote = Vote.create(voteable: @exercise, creator: current_user, vote: params[:vote])
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
  
  def exercise_params
    params.require(:exercise).permit!
  end
  
  def set_exercise
    @exercise = Exercise.find_by(slug: params[:id])
  end
end