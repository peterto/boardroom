class Service < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  
  has_many :events
  has_many :days
  
  after_save :add_days_records
  
  private
  
  def add_days_records
    Day.add_statuses_for self
  end
  
end
