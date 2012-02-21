require 'spec_helper'

describe Day do
  it { should validate_presence_of (:service_id) }
  it { should validate_presence_of (:status_id) }
  it { should validate_presence_of (:event_date) }
  
  describe "all days events" do
    # Fabricate events
    10.times do
      Fabricate(:event)
    end
    
    let(:statuses) { Day.all }
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