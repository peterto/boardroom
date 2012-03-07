require 'spec_helper'

feature "Events" do
  describe "when logged in", :driver => :selenium do
    before do
      @admin = Fabricate(:admin)
      visit "/"
      click_link "Admin"
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      
      page.current_path.should == "/services"
      page.should have_content("Create a Service")
      
      click_link "Create a Service"
      page.current_path.should == new_service_path

      name = Faker::Name.first_name
      description = Faker::Lorem.sentence
      
      fill_in 'service[name]', :with => name
      fill_in 'service[description]', :with => description

      expect {
        click_button "Create Service"
      }.to change { Service.count }.by(1) 
      
      @service = Service.last
      click_link @service.name

      page.current_path.should == service_events_path(@service)
    end
    
    scenario "should create a new event" do
      click_link "Update Status"
      @status = Fabricate(:status, :name => "Up")
      name = Faker::Product.product_name
      
      fill_in 'event[message]', :with => name
      # page.select(@status.name, :from => 'event_status_id')
      page.execute_script("$('event_status_id').val('Up')")
      click_button "Create Event"

      page.current_path.should == service_events_path(@service)
    end
    
    scenario "should edit a service from the event page" do
      click_link "Edit Service"      
      page.current_path.should == edit_service_path(@service)
    end
    
    scenario "should delete a service from the event page" do
      count = Service.count
      click_link "Delete Service"
      page.driver.browser.switch_to.alert.accept
      count.should_not == Service.count
      page.current_path.should == services_path
    end
    
  
  end
end
