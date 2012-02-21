class Day < ActiveRecord::Base
  attr_accessible :service_id, :status_id, :date
  validates :service_id, :status_id, :date, :presence => true
  
  belongs_to :service
  belongs_to :status
  
  # This essentially removes all records for this service and replaces them with new ones
  def self.update_statuses_for(service_id)
    # First delete all the day records for this particular service_id
    delete_all("service_id = #{service_id}")
    
    # Then, insert the most recent event for each of the last 6 days
    6.times do |i|
      current_time = Time.now.end_of_day - 60*60*24*i
      most_recent_event = Event.where("created_at < ? AND service_id = ?", current_time, service_id).order("created_at DESC").first
      if most_recent_event.nil?
        # A status id of 4 indicates that the status is N/A or that the service did not exist at this time
        create(:service_id => service_id, :status_id => 4, :date => Date.parse(current_time.to_s))
      else
        create(:service_id => service_id, :status_id => most_recent_event.status_id, :date => Date.parse(current_time.to_s))
      end
    end
  end
  
  def self.get_all_statuses
    order("service_id ASC, date DESC").group_by {|row| row.service_id}
  end
end