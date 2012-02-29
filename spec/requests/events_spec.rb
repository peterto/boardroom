require 'spec_helper'

feature "Events" do
  describe "when logged in" do
    scenario "should create a new event" do
      admin = Fabricate(:admin)
      visit services_path
      fill_in 'admin_email', :with => admin.email
      fill_in 'admin_password', :with => admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
      page.should have_content("Create a Service")
      
      click_link "Create a Service"
      page.current_path.should == new_service_path
      # service = Fabricate(:service)
      
      fill_in 'service[name]', :with => Faker::Lorem.word
      fill_in 'service[description]', :with => Faker::Lorem.word
      
      click_button "Create Service"
      # save_and_open_page
      
      service = Service.last
      click_link service.name
      # save_and_open_page
      
      page.current_path.should == service_events_path(service)
      
      click_link "Update Status"
      # save_and_open_page
      
      status = Fabricate(:status, :name => "Up")
      
      fill_in 'event[message]', :with => Faker::Lorem.word
      # select "Up", :from => 'event[status_id]'
      
      # page.execute_script("$('event[status_id]').val('Up')")
      
    end
    
    scenario "should edit a service from the event page" do
      admin = Fabricate(:admin)
      visit services_path
      fill_in 'admin_email', :with => admin.email
      fill_in 'admin_password', :with => admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
      page.should have_content("Create a Service")
      
      click_link "Create a Service"
      page.current_path.should == new_service_path
      # service = Fabricate(:service)
      
      fill_in 'service[name]', :with => Faker::Lorem.word
      fill_in 'service[description]', :with => Faker::Lorem.word
      
      click_button "Create Service"
      
      service = Service.last
      click_link service.name
      # save_and_open_page
      
      page.current_path.should == service_events_path(service)
      click_link "Edit Service"
      
      page.current_path.should == edit_service_path(service)
    
    end
    
    scenario "should delete a service from the event page" do
      admin = Fabricate(:admin)
      visit services_path
      fill_in 'admin_email', :with => admin.email
      fill_in 'admin_password', :with => admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
      page.should have_content("Create a Service")
      
      click_link "Create a Service"
      page.current_path.should == new_service_path
      # service = Fabricate(:service)
      
      fill_in 'service[name]', :with => Faker::Lorem.word
      fill_in 'service[description]', :with => Faker::Lorem.word
      
      click_button "Create Service"
      
      service = Service.last
      click_link service.name
      # save_and_open_page
      
      page.current_path.should == service_events_path(service)
      click_link "Delete Service"
      
      page.current_path.should == services_path
      # save_and_open_page
      
      # page.current_path.should == edit_service_path(service)
    
    end
    
  
  end
end
