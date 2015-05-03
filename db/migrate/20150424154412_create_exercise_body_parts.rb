class CreateExerciseBodyParts < ActiveRecord::Migration
  def change
    create_table :exercise_body_parts do |t|
      t.integer :exercise_id, :body_part_id
    end
  end
end
