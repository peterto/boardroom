class Status < ActiveRecord::Base
  attr_accessible :name, :image
  validates :name, :uniqueness => true, :presence => true
  validates :image, :presence => true
  
  has_many :events
  has_many :days
end
