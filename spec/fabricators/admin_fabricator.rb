Fabricator(:admin) do
   email { Fabricate.sequence(:email) { |i| "name_#{i}@mserve.com" } }
   password "joshualaroff"
   password_confirmation "joshualaroff"
end
