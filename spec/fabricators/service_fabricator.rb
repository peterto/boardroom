Fabricator(:service) do
  name { Fabricate.sequence(:name) { |i| "Service_#{i}" } }
end