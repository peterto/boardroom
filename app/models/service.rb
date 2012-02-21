class Service < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  
  has_many :events
  has_many :days
end
