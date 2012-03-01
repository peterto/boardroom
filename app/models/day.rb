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
    # Get the record for that particular day and service
    date = Date.parse(event.created_at.to_s)
    record = where("service_id = ? AND date = ?", event.service_id, date).first
    # Get the most recent event for this particular date and service_id
    unless record.nil?
      most_recent_event = Event.where("service_id = ?", event.service_id).order('created_at DESC').first
      if most_recent_event
        update(record.id, :status_id => most_recent_event.status_id)
      else
        # May need to refactor this to find the default status
        update(record.id, :status_id => 1)
      end
    end
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
    joins(:service, :status).
    select("services.name, services.id AS service_id, statuses.image").
    order("days.service_id ASC, days.date DESC").group_by(&:name)
  end
end