class EquipmentPiecesController < ApplicationController
  before_action :require_user
  before_action :set_paginated_equipment, only: [:index, :create]
  
  def index
    @equipment = EquipmentPiece.new
  end
  
  def new; end
  
  def create
    @equipment = EquipmentPiece.new(equipment_params)
    
    if @equipment.save      
      flash[:notice] = "Equipment created!"
      redirect_to equipment_pieces_path
    else
      render :index
    end
  end
  
  def show
    respond_to do |format|
      @equipment = EquipmentPiece.find_by(slug: params[:id])
      format.js
      format.html   
    end
  end
  
  private
  
  def equipment_params
    params.require(:equipment_piece).permit!
  end
  
  def set_paginated_equipment
    @equipment_pieces = EquipmentPiece.paginate(:page => params[:page], :per_page => 10).order('LOWER(name) ASC')
  end
end