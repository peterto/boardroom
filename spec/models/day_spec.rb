require 'spec_helper'

describe Day do
  it { should validate_presence_of (:service_id) }  
  it { should validate_presence_of (:status_id) }
  it { should validate_presence_of (:date) }
  
  describe "new service" do
    
    let(:service) { Fabricate(:service) }
    
    context "with no events" do
      
      it "creates 6 records for a new service" do
        records = Day.where("service_id = ?", service.id)
        records.count.should == 6
      end
      
    end
    
    context "with events" do
      
      let(:event) { Event.new(:message => 'we are down', :service_id => service.id, :status_id => 2) }
      
      it "updates the appropriate day record for a particular service when new event is created" do
        event.save
        record = Day.where("service_id = ?", service.id).order("date DESC").first
        record.status_id.should == event.status_id
      end
      
      it "updates the appropriate day record when for a particular service when event is deleted" do
        event.save
        event.destroy
        record = Day.where("service_id = ?", service.id).order("date DESC").first
        record.status_id.should == 1 # The default status: this probably needs to be defined in one place
      end
      
      it "updates day records when delayed job is called" do
        event.save
        Day.add_new_record
        records = Day.where("service_id = ?", service.id).order("date DESC")
        
        # Now, we should have two day records both with a status id of 2
        records[0].status_id.should == 2
        records[1].status_id.should == 2
      end
      
    end
    
  end
  
  # We can now seed events as well, so be sure to test this properly
  # Test that another record is added with the most recent event after running the delayed job. Ex: count the number of records for the most recent day. Should equal 2 instead of 1.
  # Test that the days table has the most recent event for each of the last 6 days.
end