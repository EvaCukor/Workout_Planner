class CreateExerciseCategories < ActiveRecord::Migration
  def change
    create_table :exercise_categories do |t|
      t.integer :exercise_id, :category_id
    end
  end
end
