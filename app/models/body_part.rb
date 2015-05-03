class BodyPart < ActiveRecord::Base
  has_many :exercise_body_parts
  has_many :exercises, through: :exercise_body_parts
  
  #validates :name, presence: true
end