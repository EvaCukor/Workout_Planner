class ExerciseEquipmentPiece < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :equipment_piece
end