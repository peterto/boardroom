require 'spec_helper'

describe Event do
  describe "new" do
    let(:event) { Event.new }
    
    context "without a message, service_id, or status_id" do  
      it "is not valid" do
        event.should_not be_valid
      end
      
      it "cannot be persisted" do
        event.save.should be_false
        Event.count.should == 0
      end
    end
    
    context "with a message, service_id, and status_id" do
      before(:each) do
        event.message = 'Test Message'
        event.service_id = 1
        event.status_id = 1
      end
      
      it "is valid" do
        event.should be_valid
      end
      
      it "can be persisted" do
        event.save.should be_true
        Event.count.should == 1
      end
    end
  end
  
  describe "all days events" do
    # What database does this use? The test database? How do I populate the test database?
    let(:statuses) { Days.get_all_statuses }
    let(:services) { Service.all }
    
    it "returns the most recent status for each of the last 6 days for every service" do      
      services.each do |service|
        6.times do |i|
          # Get the date to look at and make sure the status is the most recent status past that date 
          end_time = Time.now.end_of_day - 60*60*24*i
          recent_status_image = service.statuses.where("events.created_at < #{end_time}").order("events.created_at DESC").first.image
          recent_status_image.should == statuses[service.name][i]
        end
      end
    end
    
  end
end