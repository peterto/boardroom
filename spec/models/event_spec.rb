require 'spec_helper'

describe Event do
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:service_id) }
  it { should validate_presence_of(:status_id) }
  
  describe "new" do
    let(:event) { Event.new }
    
    context "without a message, service_id, or status_id" do  
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
      
      it "can be persisted" do
        event.save.should be_true
        Event.count.should == 1
      end
      
      it "updates day records upon save" do
        event.save
        recent_status = Day.where("service_id = #{event.service_id}").order("date DESC").first
        recent_status.status_id.should == event.status_id
      end
      
    end
  end
  
end