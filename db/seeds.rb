# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed with Statuses and a Service
Status.create(:name => 'Up', :image => 'up.jpg', :description => 'The service is up')
Status.create(:name => 'Down', :image => 'down.jpg', :description => 'The service is down')
Status.create(:name => 'Warning', :image => 'warning.jpg', :description => 'The service is experiencing issues')

Service.create(:name => 'Shaan Service', :description => 'This is my service yo!')