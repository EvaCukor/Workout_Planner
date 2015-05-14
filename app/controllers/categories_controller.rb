class CategoriesController < ApplicationController
  before_action :require_user
    
  def index
    #@categories = Category.all.sort_by{ |x| x.name.downcase }
    @categories = Category.paginate(:page => params[:page], :per_page => 10).order('LOWER(name) ASC')
    @category = Category.new
  end
  
  def new; end
  
  def create
    @category = Category.new(categories_params)
    @categories = Category.paginate(:page => params[:page], :per_page => 10).order('LOWER(name) ASC')
    
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
      #@exercises = Exercise.find_by(@category.id)
      #@exercises = Exercise.paginate(:page => params[:page], :per_page => 2).order('LOWER(name) ASC')
      format.js
      format.html   
    end
  end
  
  private
  
  def categories_params
    params.require(:category).permit!
  end
end