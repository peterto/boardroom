class Status < ActiveRecord::Base
  attr_accessible :name, :image, :description
  validates :name, :uniqueness => true, :presence => true
  # validates :image, :uniqueness => true, :presence => true
  validates :image, :presence => true
  validates :description, :presence => true
  
  has_many :events
  has_many :services, :through => :events
  has_many :days
end