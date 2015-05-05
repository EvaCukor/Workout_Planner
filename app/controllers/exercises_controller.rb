class ExercisesController < ApplicationController
  before_action :require_user
  
  def index
    @exercises = Exercise.all.sort_by{ |x| x.name.downcase }
    if session[:exercise_id]
      @exercise = Exercise.find(session[:exercise_id])
    end
  end
  
  def new
    @exercise = Exercise.new    
    @category = Category.new
    @equipment = EquipmentPiece.new
  end
  
  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.creator = current_user
    
    if params[:commit] == "Cancel"
      redirect_to exercises_path
    elsif @exercise.save
      session[:exercise_id] = @exercise.id
      flash[:notice] = "Exercise created!"
      redirect_to exercises_path
    else
      render :new
    end
  end
  
  def show
    respond_to do |format|
      @exercise = Exercise.find_by(slug: params[:id])
      session[:exercise_id] = @exercise.id
      format.js
      format.html
      #format.html { redirect_to exercises_path }      
    end
  end
  
  def edit
    @exercise = Exercise.find_by(slug: params[:id])
  end
  
  def update
    @exercise = Exercise.find(params[:id])
    session[:exercise_id] = @exercise.id
    if params[:commit] == "Cancel"      
      redirect_to exercises_path
    elsif @exercise.update_attributes(exercise_params)
      flash[:notice] = "The exercise was updated."
      redirect_to exercises_path
    else
      render :edit
    end
  end
  
  def destroy
    @exercise = Exercise.find_by(slug: params[:id])
    @exercise.destroy
    session[:exercise_id] = nil

    respond_to do |format|
      format.js { @exercises = Exercise.all.sort_by{ |x| x.name.downcase } }
      format.html { redirect_to exercises_path }
    end
  end
  
  private
  
  def exercise_params
    params.require(:exercise).permit!
  end
end