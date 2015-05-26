class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name, :slug
      t.text :comment
      t.integer :reps, :sets, :user_id, :rest_min, :rest_sec, :interval_min, :interval_sec
      
      t.timestamps
    end
  end
end
