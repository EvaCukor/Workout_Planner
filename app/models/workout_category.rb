class WorkoutCategory < ActiveRecord::Base
  belongs_to :workout
  belongs_to :category
end