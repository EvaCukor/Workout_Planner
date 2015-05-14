class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :name, :interval, :rest
      t.text :comment
      t.integer :reps, :sets, :user_id
      
      t.timestamps
    end
  end
end
