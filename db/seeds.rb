# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Seed with Statuses and a Service
Status.create(:name => 'up', :image => 'up.jpg')
Status.create(:name => 'down', :image => 'down.jpg')
Status.create(:name => 'warning', :image => 'warning.jpg')
Status.create(:name => 'default', :image => 'default.jpg')

Service.create(:name => 'hello', :description => 'hello world!')