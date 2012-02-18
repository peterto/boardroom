class Status < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  validates :image, :presence => true
end
