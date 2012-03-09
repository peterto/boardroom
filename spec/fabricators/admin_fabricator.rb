Fabricator(:admin) do
   # email { Fabricate.sequence(:email) { |i| "name_#{i}@mserve.com" } }
   email Faker::Internet.email
   password "joshualaroff"
   password_confirmation "joshualaroff"
end
