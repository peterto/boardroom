require 'spec_helper'

describe Status do
  it { should validate_presence_of (:name) }
  it { should validate_presence_of (:image) }
  
  describe "new" do
    let(:status) { Status.new }

    context "without a name" do  
      it "is not valid" do
        status.should_not be_valid
      end
      
      it "cannot be persisted" do
        status.save.should be_false
        Status.count.should == 0
      end
    end
    
    context "with a name and image" do
      
      before(:each) do
        status.name = 'New Status'
        status.image = 'service-up.jpg'
      end
        
      it "is valid" do
        status.should be_valid
      end
      
      it "can be persisted" do
        status.save.should be_true
        Status.count.should == 1
      end
      
      it "is unique" do        
        status.save
        unique_name_status = Status.new(:name => "New Status")
        unique_name_status.should_not be_valid
        unique_name_status.save.should be_false
      end
    end
  end
end
