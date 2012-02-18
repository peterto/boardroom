class Event < ActiveRecord::Base
  validates :message, :service_id, :status_id, :presence => true
end
