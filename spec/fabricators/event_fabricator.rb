Fabricator(:event) do
  message { Fabricate.sequence(:message) { |i| "Event_#{i}" } }
  service_id { Random.new.rand(1..3) }
  status_id { Random.new.rand(1..3) }
end