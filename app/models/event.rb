class Event < ActiveRecord::Base
  attr_accessor :message, :service_id, :status_id
  validates :message, :service_id, :status_id, :presence => true
  
  after_save :update_days_records
  after_update :update_days_records
  
  private
  
  def update_days_records
    Day.update_statuses_for self.service_id
  end

end