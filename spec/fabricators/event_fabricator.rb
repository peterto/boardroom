Fabricator(:event) do
  message 'test message'
  service_id 1
  status_id 2
  created_at { Fabricate.sequence(:created_at) { |i| Time.now().end_of_day - 60*60*24*i } }
end