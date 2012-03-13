class Day < ActiveRecord::Base
  attr_accessible :service_id, :status_id, :date
  validates :service_id, :status_id, :date, :presence => true
  
  belongs_to :service
  belongs_to :status
  
  # On service creation, create 6 day records
  def self.add_statuses_for(service)
    # Insert six rows into the table for this service with status id of 1
    6.times do |i|
      date = Date.today - i.day
      create(:service_id => service.id, :status_id => 1, :date => date)
    end
  end
  
  # For status change and status deletion
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
  # Refresh all records from today to the most recent date
  def self.refresh_records
    services = Service.all
    services.each do |service|
      latest_record = Day.where("service_id = ?", service.id).order("date DESC").first
      latest_record_date = latest_record.date
      
      # For every record we create, we will need to delete a record, so that we always maintain 6 records per service
      records_to_delete = Day.where("service_id = ?", service.id).order("date ASC")
      
      # Count the number of records that we need to create
      difference = (Date.today - latest_record_date).to_i
      
      difference.times do |i|
        create(:service_id => service.id, :status_id => latest_record.status_id, :date => Date.today - i.day)
        # ID of record to destroy. Remember, i starts at one but the records array is 0-indexed.
        delete(records_to_delete[i].id)
      end
    end
  end
  
  def self.get_all_statuses
    joins(:service, :status).
    select("services.name, services.id AS service_id, statuses.image, statuses.description, statuses.name AS status_name, days.date").
    order("days.service_id ASC, days.date DESC").group_by(&:name)
  end
  
  def self.get_recent_date
    order('date DESC').first.date
  end
end