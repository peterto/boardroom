Fabricator(:status) do
  name { Fabricate.sequence(:name) { |i| "Status_#{i}" } }
  image { Fabricate.sequence(:image) { |i| "Image_#{i}" } }
  description { Fabricate.sequence(:description) { |i| "Description_#{i}" } }
end
