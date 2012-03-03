require 'spec_helper'

feature "services" do
  describe "when" do
    before do
      visit root_path
      @admin = Fabricate(:admin, :email => Faker::Internet.email)
      visit services_path
      # save_and_open_page
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
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
      page.current_path.should == services_path
    end
    
    scenario "logged out should see the index page" do
      # save_and_open_page
      # service = Fabricate(:service)
      # service = Fabricate(:service)
      # visit services_path
      # save_and_open_page
      page.should have_content("Service")
    end
    
    scenario "logged in should redirect to the services admin page" do
      # save_and_open_page
      page.should have_content("Create a Service")
      page.current_path.should == services_path
      # page.should 
    end
    
    scenario "logged in should create a service" do
      service = Service.last
      # page.current_path.should == service_path(service)
    end
    
    scenario "logged in should create a service and then delete the service" do
      click_link "Delete"
      # save_and_open_page
      page.current_path.should == services_path
    end
    
    scenario "logged in should create a service and then edit the service" do
      click_link "Edit"
      service = Service.last
      page.current_path.should == edit_service_path(service)
      
      # page.current_path.should == services_path
      # save_and_open_page
      
      fill_in 'service[name]', :with => Faker::Lorem.word
      fill_in 'service[description]', :with => Faker::Lorem.word
      # save_and_open_page
      
      click_button "Update Service"
      page.current_path.should == services_path
      # save_and_open_page
    end
    
  end
  

end