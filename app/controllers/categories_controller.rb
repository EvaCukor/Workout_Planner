class CategoriesController < ApplicationController
  before_action :require_user, except: [:index]
  
  def index
    @categories = Category.all.sort_by{ |x| x.name.downcase }
    @category = Category.new
  end
  
  def new; end
  
  def create
    @category = Category.new(categories_params)
    @categories = Category.all.sort_by{ |x| x.name.downcase }
    
    if @category.save
      flash[:notice] = "Category created!"
      redirect_to categories_path
    else
      render :index
    end
  end
  
  def show
    respond_to do |format|
      @category = Category.find(params[:id])
      format.js
      format.html   
    end
  end
  
  private
  
  def categories_params
    params.require(:category).permit!
  end
end