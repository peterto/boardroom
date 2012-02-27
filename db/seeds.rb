# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed with Statuses and a Service
Status.create(:name => 'Up', :image => 'up.jpg')
Status.create(:name => 'Down', :image => 'down.jpg')
Status.create(:name => 'Warning', :image => 'warning.jpg')

Service.create(:name => 'Shaan Service', :description => 'This is my service yo!')