class Workout < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises
  
  has_many :workout_categories
  has_many :categories, through: :workout_categories
  
  validates :name, presence: true
  validates :exercises, presence: true #validates_existence_of
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  sluggable_column :name
end