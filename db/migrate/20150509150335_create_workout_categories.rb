class CreateWorkoutCategories < ActiveRecord::Migration
  def change
    create_table :workout_categories do |t|
      t.integer :workout_id, :category_id
    end
  end
end
