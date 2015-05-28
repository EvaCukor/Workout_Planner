class Workout < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises
  
  has_many :workout_categories
  has_many :categories, through: :workout_categories
  
  has_many :votes, as: :voteable
  
  validates :name, presence: true
  validates :exercises, presence: true
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  sluggable_column :name
  
  before_save :name
  before_save :comment
  
  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
  
  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end
  
  def comment=(s)
    write_attribute(:comment, s.to_s.capitalize)
  end
end