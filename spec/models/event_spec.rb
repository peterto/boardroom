require 'spec_helper'

describe Event do
  describe "New" do
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
  
  pending "All Days Events"
end