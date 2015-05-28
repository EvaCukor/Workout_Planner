class ExerciseCategory < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :category
end