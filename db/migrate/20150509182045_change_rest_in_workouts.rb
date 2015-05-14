class ChangeRestInWorkouts < ActiveRecord::Migration
  def change
    rename_column :workouts, :rest, :rest_min
    change_column :workouts, :rest_min, :integer 
    add_column :workouts, :rest_sec, :integer
  end
end
