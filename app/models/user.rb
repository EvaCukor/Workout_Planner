class User < ActiveRecord::Base
  include Sluggable
  
  has_secure_password validations: false
  
  has_many :exercises
  has_many :workouts
  has_many :categories
  has_many :equipment_pieces
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  sluggable_column :username
end