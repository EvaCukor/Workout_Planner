class ChangeIntervalInWorkouts < ActiveRecord::Migration
  def change
    rename_column :workouts, :interval, :interval_min
    change_column :workouts, :interval_min, :integer 
    add_column :workouts, :interval_sec, :integer
  end
end
