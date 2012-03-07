require 'spec_helper'

feature "Admins" do
  describe "should", :driver => :selenium do
    before do
      @admin = Fabricate(:admin)
      visit root_path
      click_link "Admin"
    end
    
    scenario "create a new user when not logged in" do
      click_link "Sign up"
      
      fill_in 'admin_email', :with => Faker::Internet.email
      fill_in 'admin_password', :with => "password"
      fill_in 'admin_password_confirmation', :with => "password"
      
      click_button "Sign up"
      page.current_path.should == services_path
      
    end
    
    scenario "sign in with an existing user" do
      fill_in 'admin_email', :with => @admin.email
      fill_in 'admin_password', :with => @admin.password
      click_button "Sign in"
      page.current_path.should == services_path
    end
  
  end
end
