Fabricator(:event) do
  message 'test message'
  service_id { Random.new.rand(1..3) }
  status_id { Random.new.rand(1..3) }
  created_at { Fabricate.sequence(:created_at) { |i| Time.now().end_of_day - 60*60*24*i } }
end