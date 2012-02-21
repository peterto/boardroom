class Event < ActiveRecord::Base
  attr_accessible :message, :service_id, :status_id
  validates :message, :service_id, :status_id, :presence => true
  
  belongs_to :service
  belongs_to :status

  after_save :update_days_records
  
  private
  
  def update_days_records
    Day.update_statuses_for self.service_id
  end

end