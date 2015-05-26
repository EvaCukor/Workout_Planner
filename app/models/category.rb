class Category < ActiveRecord::Base
  include Sluggable
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  
  belongs_to :categorizeable, polymorphic: true
  
  validates :name, presence: true
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  sluggable_column :name
  
  before_save :name
  
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
end