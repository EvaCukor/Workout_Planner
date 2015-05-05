class EquipmentPiecesController < ApplicationController
  before_action :require_user
  
  def index
    @equipment_pieces = EquipmentPiece.all.sort_by{ |x| x.name.downcase }
    @equipment = EquipmentPiece.new
  end
  
  def new; end
  
  def create
    @equipment = EquipmentPiece.new(equipment_params)
    @equipment_pieces = EquipmentPiece.all.sort_by{ |x| x.name.downcase }
    
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
end