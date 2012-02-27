class Day < ActiveRecord::Base
  attr_accessible :service_id, :status_id, :date
  validates :service_id, :status_id, :date, :presence => true
  
  belongs_to :service
  belongs_to :status
  
  # On service creation, create 6 day records
  def self.add_statuses_for(service)
    # Insert six rows into the table for this service with status id of 4
    6.times do |i|
      date = Date.today - i
      create(:service_id => service.id, :status_id => 1, :date => date)
    end
  end
  
  # For status change
  def self.update_record_with(event)
    # For testing purposes - use Rails.env.test? or Rails.env.development?
      # First, determine if this is the most recent event of that particular day    
      # Then, if it is, find the record of that particular day. If that record exists, update it with the event status
    record = where("service_id = ?", event.service_id).order("date DESC").first
    update(record.id, :status_id => event.status_id) unless record.nil?
  end
  
  # For delayed job
  def self.add_new_record
    services = Service.all
    services.each do |service|
      # Find the most recent event for a service
      event = Event.where("service_id = ?", service.id).order("created_at DESC").limit(1).first

      # Insert a day record for most recent event
      create(:service_id => event.service_id, :status_id => event.status_id, :date => Date.parse(event.created_at.to_s))

      # Delete the last day record so that we always maintain six records per service
      last_id = where("service_id = ?", event.service_id).order("date ASC").first.id
      delete(last_id)
    end
  end
  
  def self.get_all_statuses
    joins(:service, :status).select("services.name, services.id AS service_id, statuses.image").order("days.service_id ASC, days.date DESC").group_by { |row| row.name }
  end
end