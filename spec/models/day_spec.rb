require 'spec_helper'

describe Day do
  it { should validate_presence_of (:service_id) }
  it { should validate_presence_of (:status_id) }
  it { should validate_presence_of (:date) }
  
  describe "all days events" do
    # Fabricate events
    1.times do
      Fabricate(:event, :service_id => 1)
      Fabricate(:event, :service_id => 2)
    end
    
    # Fabricate services 
    Fabricate(:service, :id => 1)
    Fabricate(:service, :id => 2)
    
    let(:days) { Day.get_all_statuses }
    let(:services) { Service.all }
    
    it "returns the most recent status for each of the last 6 days for each service" do
      services.each do |service|
        6.times do |i|
          # Get the date to look at and make sure the status is the most recent status past that date 
          end_time = Time.now.end_of_day - 60*60*24*i
          record_status = service.events.where("events.created_at < ?", end_time).order("events.created_at DESC").first
          if record_status.nil?
            status = 4
          else
            status = record_status.status_id
          end
          status.should == days[service.id][i].status_id
        end
      end
    end
    
    it "returns 6 days of information for each service" do
      services.each do |service|
        days[service.id].count == 6
      end
    end
  end

end