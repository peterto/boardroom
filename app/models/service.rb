class Service < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  
  has_many :events, :dependent => :destroy
  has_many :statuses, :through => :events
  has_many :days
  
  after_save :add_days_records
  
  def get_all_statuses
    statuses.select("events.id, events.message, events.created_at, statuses.image").order("events.created_at DESC")
  end
  
  def self.get_events
    service_events = {}
    Service.all.each do |service|
      service_events[service.name] = service.events.last
    end
    service_events
  end
  
  private
  
  def add_days_records
    Day.add_statuses_for self
  end
  
end
