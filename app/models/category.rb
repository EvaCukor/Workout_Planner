class Category < ActiveRecord::Base
  has_many :exercise_categories
  has_many :exercises, through: :exercise_categories
  
  validates :name, presence: true
  
  validates_uniqueness_of :name, :case_sensitive => false
end