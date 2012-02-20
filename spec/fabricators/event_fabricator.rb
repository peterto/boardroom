Fabricator(:event) do
  message { Fabricate.sequence(:message) { |i| "Event_#{i}" } }
  service_id '1'
  status_id '1'
end

# validates :message, :service_id, :status_id, :presence => true