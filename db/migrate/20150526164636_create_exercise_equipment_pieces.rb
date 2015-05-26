class CreateExerciseEquipmentPieces < ActiveRecord::Migration
  def change
    create_table :exercise_equipment_pieces do |t|
      t.integer :exercise_id, :equipment_piece_id
    end
  end
end