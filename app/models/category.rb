class Category < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  has_many :exercise_categories
  has_many :exercises, through: :exercise_categories
  
  has_many :workout_categories
  has_many :workouts, through: :workout_categories
  
  validates :name, presence: true
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  sluggable_column :name
end