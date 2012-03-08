require 'spec_helper'

feature "services" do
  describe "when", :driver => :selenium do
    before do
      visit root_path
      @admin = Fabricate(:admin, :email => Faker::Internet.email)
      
      visit services_path
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      page.current_path.should == services_path
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
      
      page.current_path.should == services_path
      @service = Service.last

    end
    
    scenario "logged out should see the index page" do
      pending "This should check to make sure the user is logged out when they click Log out"
      # click_link "Log out"
      # page.should have_content("Service")
      # page.current_path.should == root_path
    end
    
    scenario "logged in should redirect to the services admin page" do
      page.should have_content("Create a Service")
      page.current_path.should == services_path
      # page.should 
    end
    
    # scenario "logged in should create a service" do
    #   service = Service.last
    #   page.current_path.should == service_path(service)
    # end
    
    scenario "logged in should create a service and then delete the service" do
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      page.current_path.should == services_path
    end
    
    scenario "logged in should create a service and then edit the service" do
      click_link "Edit"
      # service = Service.last
      page.current_path.should == edit_service_path(@service)

      name = Faker::Name.first_name
      description = Faker::Lorem.word

      fill_in 'service[name]', :with => name
      fill_in 'service[description]', :with => description
      click_button "Update Service"
      
      service = Service.last
      service.name.should == name
      service.description.should == description
      
      page.current_path.should == services_path
    end
    
    scenario "will not allow the user to create a duplicate service" do
      click_link "Create a Service"
      page.current_path.should == new_service_path
      
      count = Service.count
      
      fill_in 'service[name]', :with => @service.name
      fill_in 'service[description]', :with => @service.description
      click_button "Create Service"
      
      count.should == Service.count
      page.should have_content("Name has already been taken")

    end
    
  end
  

end