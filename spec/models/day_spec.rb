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
      
      it "refreshes day records" do
        latest_record = Day.where("service_id = ?", service.id).order("date DESC").first
        Day.update(latest_record.id, :date => Date.today - 1.day)
        
        # Run the refresh records method
        Day.refresh_records
        
        # Now, we should have 6 day records still and the latest being today's date
        Day.where("service_id = ?", service.id).count.should == 6
        Day.where("service_id = ?", service.id).order("date DESC").first.date.should == Date.today
      end
      
    end
    
  end
  
end