require 'spec_helper'

feature "admins" do
  describe "should", :js => true do
    before do
      @admin = Fabricate(:admin)
      visit "/"
      click_link "Admin"
    end
    
    scenario "create a new user when not logged in", :js => true do
      click_link "Sign up"
      
      fill_in 'admin_email', :with => Faker::Internet.email
      fill_in 'admin_password', :with => "password"
      fill_in 'admin_password_confirmation', :with => "password"
      
      click_button "Sign up"
      page.current_path.should == services_path
      
    end
    
    scenario "sign in with an existing user", :js => true do
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      page.current_path.should == services_path
    end
  
  end
end
