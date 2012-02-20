Fabricator(:status) do
  name { Fabricate.sequence(:name) { |i| "Status_#{i}" } }
  image { Fabricate.sequence(:image) { |i| "Status_img_#{i}" } }
end

# validates :name, :uniqueness => true, :presence => true
# validates :image, :presence => true