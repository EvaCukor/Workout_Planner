class ExerciseBodyPart < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :body_part
end