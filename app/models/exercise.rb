class Exercise < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :exercise_equipment_pieces
  has_many :equipment_pieces, through: :exercise_equipment_pieces
  has_many :exercise_body_parts
  has_many :body_parts, through: :exercise_body_parts
  has_many :exercise_categories
  has_many :categories, through: :exercise_categories
  
  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  validates :difficulty, presence: true
  validate :has_at_least_one_body_part

  def has_at_least_one_body_part
    if body_parts.empty?
      errors.add(:exercises, "need to have a defined targeted body part")
    end
  end
end