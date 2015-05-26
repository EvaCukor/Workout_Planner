class BodyPart < ActiveRecord::Base
  has_many :exercise_body_parts
  has_many :exercises, through: :exercise_body_parts
  
  before_save :name
  
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
end