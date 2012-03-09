require 'spec_helper'

feature "statuses" do
  describe "when", :js => true do
    before do
      @admin = Fabricate(:admin)
      visit "/"
      click_link "Admin"
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
    end
    
    scenario "logged in, should create a new status", :js => true do
      click_link "Statuses"
      click_link "Create a Status"
      name = Faker::Lorem.word
      description = Faker::Lorem.sentence
      
      fill_in "status[name]", :with => name
      fill_in "status[description]", :with => description
      page.choose('status_image_big_upjpg')
      
      expect {
        click_button "Create Status"
      }.to change { Status.count }.by(1)

      status = Status.last      
      page.should have_content(status.name)
      page.current_path.should == statuses_path
      
    end
    
    scenario "logged in, destroy a status", :js => true do
      click_link "Statuses"
      click_link "Create a Status"
      name = Faker::Lorem.word
      description = Faker::Lorem.sentence
      
      fill_in "status[name]", :with => name
      fill_in "status[description]", :with => description
      page.choose('status_image_big_upjpg')
      click_button "Create Status"

      status = Status.last      
      page.should have_content(status.name)
      page.current_path.should == statuses_path
      
      expect {
        click_link "Delete"
        page.driver.browser.switch_to.alert.accept
      }.to change { Status.count }.by(-1)
    
    end
    
    scenario "logged in, should update a status", :js => true do
      click_link "Statuses"
      click_link "Create a Status"
      name = Faker::Lorem.word
      description = Faker::Lorem.sentence
      
      fill_in "status[name]", :with => name
      fill_in "status[description]", :with => description
      page.choose('status_image_big_upjpg')
      
      expect {
        click_button "Create Status"
      }.to change { Status.count }.by(1)
      
      status = Status.last      
      page.should have_content(status.name)
      page.current_path.should == statuses_path
      
      click_link "Edit"
      name_new = Faker::Lorem.word
      description_new = Faker::Lorem.sentence
      
      fill_in "status[name]", :with => name_new
      fill_in "status[description]", :with => description_new
      page.choose('status_image_upjpg')
      click_button "Update Status"
      
      page.should have_content(name_new)
      page.current_path.should == statuses_path
      
    end
  end
end