require 'spec_helper'

describe Service do 
  describe "new" do
    let(:service) { Service.new }
    
    context "without a name" do  
      it "is not valid" do
        service.should_not be_valid
      end
      
      it "cannot be persisted" do
        service.save.should be_false
        Service.count.should == 0
      end
    end
    
    context "with a name" do
      
      before(:each) do
        service.name = 'New Service'
      end
        
      it "is valid" do
        service.should be_valid
      end
      
      it "can be persisted" do
        service.save.should be_true
        Service.count.should == 1
      end
      
      it "is unique" do
        service.save
        unique_name_service = Service.new(:name => "New Service")
        unique_name_service.should_not be_valid
        unique_name_service.save.should be_false
      end
    end
  end
end