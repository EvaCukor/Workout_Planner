class User < ActiveRecord::Base
  include Sluggable
  
  has_secure_password validations: false
  
  has_many :exercises
  has_many :workouts
  has_many :categories
  has_many :equipment_pieces
  has_many :votes
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  
  sluggable_column :username
  
  before_save :username
  
  def username=(s)
    write_attribute(:username, s.to_s.titleize)
  end
end