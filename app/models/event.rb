class Event < ActiveRecord::Base
  attr_accessible :message, :service_id, :status_id
  validates :message, :service_id, :status_id, :presence => true
  
  belongs_to :service
  belongs_to :status

  after_save :update_day_record
  # Need to have a call back for after_delete. This will have to recalculate the day record which occurred on the same day of the deleted event (if that record is outside the range, then no need to worry) 
  
  after_destroy :update_day_record
  
  private
  
  def update_day_record
    Day.update_record_with self
  end

end