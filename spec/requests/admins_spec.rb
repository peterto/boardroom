require 'spec_helper'

feature "Admins" do
  describe "should" do
    scenario "create a new user when not logged in" do
      visit root_path
      click_link "Admin"
      
      click_link "Sign up"
      # save_and_open_page
      
      fill_in 'admin_email', :with => Faker::Internet.email
      fill_in 'admin_password', :with => "password"
      fill_in 'admin_password_confirmation', :with => "password"
      # save_and_open_page
      
      click_button "Sign up"
      # save_and_open_page
      #   fill_in 'admin_email', :with => Faker::Internet.email
      #   fill_in 'admin_password', :with => "password"
      #   click_button "Sign in"
      #   save_and_open_page
      page.current_path.should == services_path
      
    end
    
    scenario "sign in with an existing user" do
      admin = Fabricate(:admin)
      visit services_path
      fill_in 'admin_email', :with => admin.email
      fill_in 'admin_password', :with => admin.password
      click_button "Sign in"
      
      page.current_path.should == services_path
    end
  
  end
end
