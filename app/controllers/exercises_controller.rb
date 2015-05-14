class ExercisesController < ApplicationController
  before_action :require_user
  
#   def index
#     @exercises = Exercise.all.sort_by{ |x| x.name.downcase }
#     #@exercises = Exercise.paginate(:page => params[:page], :per_page => 2).order('LOWER(name) ASC')
#     respond_to do |format|
#       format.js
#       #format.html   
#     end
#   end
  
  def new
    @exercise = Exercise.new    
    @categories = Category.all.sort_by{ |x| x.name.downcase }
    @equipment = EquipmentPiece.all.sort_by{ |x| x.name.downcase }
  end
  
  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.creator = current_user
    
    if params[:commit] == "Cancel"
      redirect_to exercises_path
    elsif @exercise.save
      #session[:exercise_id] = @exercise.id
      flash[:notice] = "Exercise created!"
      redirect_to exercises_path
    else
      render :new
    end
  end
  
  def show
    respond_to do |format|
      @exercise = Exercise.find_by(slug: params[:id])
      #session[:exercise_id] = @exercise.id
      session[:prev_url] = request.referer
      format.js
      format.html   
    end
  end
  
  def edit
    @exercise = Exercise.find_by(slug: params[:id])
    @categories = Category.all.sort_by{ |x| x.name.downcase }
    @equipment = EquipmentPiece.all.sort_by{ |x| x.name.downcase }
    session[:prev_url] = request.referer
  end
  
  def update
    @exercise = Exercise.find_by(slug: params[:id])
    #session[:exercise_id] = @exercise.id
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
    @exercise = Exercise.find_by(slug: params[:id])  
    
    if params[:commit] == "Cancel"
      redirect_to session[:prev_url]
    else
      respond_to do |format|
        @exercise.destroy
        #session[:exercise_id] = nil
        format.js { @exercises = Exercise.all.sort_by{ |x| x.name.downcase } }
        format.html { redirect_to session[:prev_url] }        
      end
    end
  end
  
  private
  
  def exercise_params
    params.require(:exercise).permit!
  end
end