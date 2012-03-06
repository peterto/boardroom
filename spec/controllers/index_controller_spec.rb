require 'spec_helper'

describe IndexController do
  
  before(:each) do
    @service = Fabricate(:service)
    4.times do |i|
      Fabricate(:status, :id => i)
    end
  end
  
  it "assigns all statuses from Day model to @statuses" do
    get :index
    assigns(:statuses).count.should == 1 # There should only be 1 array for one service
    assigns(:statuses)[@service.name].count.should == 6 # There should be 6
  end
  
  it "updates day records if recent record date does not match current date" do
    # First, modify the most recent record date
    record = Day.where("service_id = ?", @service.id).order("date DESC").first
    Day.update(record.id, :date => Date.today - 1.day)
    
    # Then, check that the most recent record has today's date
    get :index
    assigns(:statuses)[@service.name][0].date.should == Date.today
  end
  
end
