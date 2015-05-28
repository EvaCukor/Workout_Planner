class CategoriesController < ApplicationController
  before_action :require_user
  before_action :set_paginated_categories, only: [:index, :create]
    
  def index
    @category = Category.new
  end
  
  def new; end
  
  def create
    @category = Category.new(categories_params)
    @category.creator = current_user
    
    if @category.save
      flash[:notice] = "Category created!"
      redirect_to categories_path
    else
      render :index
    end
  end
  
  def show
    respond_to do |format|
      @category = Category.find_by(slug: params[:id])
      #@category_exercises = Category.find_by(categorizeable_type: 'Exercise')
      #@category_workouts = Category.find_by(categorizeable_type: 'Workout')
      format.js
      format.html
    end
  end
  
  private
  
  def categories_params
    params.require(:category).permit!
  end
  
  def set_paginated_categories
    @categories = Category.paginate(:page => params[:page], :per_page => 10).order('LOWER(name) ASC')
  end
end