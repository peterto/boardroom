class Day < ActiveRecord::Base
  attr_accessor :service_id, :status_id, :date
  validates :service_id, :date, :presence => true
  
  # This essentially removes all records for this service and replaces them with new ones
  def self.update_statuses_for(service_id)
    # First delete all the day records for this particular service_id
    delete_all("service_id = #{service_id}")
    
    # Then, insert the most recent event for each of the last 6 days
    6.times do |i|
      most_recent_event = Event.where("created_at < (CURRENT_TIMESTAMP - interval '#{i}' day) AND service_id = #{service_id}").order("created_at DESC").first
      create( :service_id => service_id, :status_id => most_recent_event.status_id, :date => Date.parse(current_timestamp.to_s) )
    end
    
  end
end