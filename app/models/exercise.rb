class Exercise < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  has_many :exercise_equipment_pieces
  has_many :equipment_pieces, through: :exercise_equipment_pieces
  
  has_many :exercise_body_parts
  has_many :body_parts, through: :exercise_body_parts
  
  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises
  
  has_many :categories, as: :categorizeable
  
  has_many :votes, as: :voteable
  
  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  validates :difficulty, presence: true
  validate :has_at_least_one_body_part
  
  sluggable_column :name
  
  mount_uploader :image, ImageUploader
  
  before_save :name
  before_save :description

  def has_at_least_one_body_part
    if body_parts.empty?
      errors.add(:exercises, "need to have a defined targeted body part")
    end
  end
  
  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
  
  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end
  
  def description=(s)
    write_attribute(:description, s.to_s.capitalize)
  end
end