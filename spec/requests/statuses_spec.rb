require 'spec_helper'

feature "statuses" do
  describe "when", :driver => :selenium do
    before do
      visit root_path
      @admin = Fabricate(:admin, :email => Faker::Internet.email)
      
      visit services_path
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
    end
    
    scenario "logged in, should create a new status" do
      click_link "Statuses"
      click_link "Create a Status"
      name = Faker::Lorem.word
      description = Faker::Lorem.sentence
      
      fill_in "status[name]", :with => name
      fill_in "status[description]", :with => description
      page.choose('status_image_big_upjpg')
      # save_and
      click_button "Create Status"
      save_and_open_page
      status = Status.last
      
      page.should have_content(status.name)
      page.current_path.should == statuses_path
      
    end
    
    # scenario "logged in should update a status" do
    # end
    # 
    # scenario "logged in should delete a status" do
    # end
    
  end
  

end