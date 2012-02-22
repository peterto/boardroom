require 'spec_helper'

describe Day do
  it { should validate_presence_of (:service_id) }  
  it { should validate_presence_of (:status_id) }
  it { should validate_presence_of (:date) }
  
  describe "new service" do
    it "creates 6 records for a new service" do
      Fabricate(:service, :id => 1)
      records = Day.where("service_id = ?", 1)
      records.count.should == 6
    end
  end
  
  describe "new event" do
    it "updates the most recent day record for a particular service" do 
      Fabricate(:service, :id => 1) # This creates the 6 records
      Fabricate(:event, :service_id => 1) # This should update the most recent record
      recent_record = Day.where("service_id = ?", 1).order("date DESC").first
      recent_record.status_id.should_not == 4
    end
  end
  
  # Test that another record is added with the most recent event after running the delayed job. Ex: count the number of records for the most recent day. Should equal 2 instead of 1.
  # Test that the days table has the most recent event for each of the last 6 days. Do this using the notes in the day model.
end