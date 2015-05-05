class EquipmentPiece < ActiveRecord::Base
  include Sluggable
  
  belongs_to :user
  has_many :exercise_equipment_pieces
  has_many :exercises, through: :exercise_equipment_pieces
  
  validates :name, presence: true
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  sluggable_column :name
end