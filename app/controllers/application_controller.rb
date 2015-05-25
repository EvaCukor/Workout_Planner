class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to login_path
    else
    end
  end
  
  def checkboxes_categories
    @categories = Category.all.sort_by{ |x| x.name.downcase }
  end
  
  def checkboxes_equipment
    @equipment = EquipmentPiece.all.sort_by{ |x| x.name.downcase }
  end
  
  def checkboxes_body_parts
    @body_parts = BodyPart.all.sort_by{ |x| x.name.downcase }
  end
  
  def checkboxes_exercises
    @exercises = Exercise.all.sort_by{ |x| x.name.downcase }
  end
end