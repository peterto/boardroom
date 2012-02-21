Fabricator(:event) do
  message 'test message'
  service_id { Random.new.rand(1..3) }
  status_id { Random.new.rand(1..3) }
end