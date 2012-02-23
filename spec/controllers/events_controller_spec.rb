require 'spec_helper'

describe EventsController do

  # let(:event) { Event.new }
  
  describe 'index' do
    
    # before(:each) do
    #   event.message = 'Test Message'
    #   event.service_id = 1
    #   event.status_id = 1
    #   event.save
    # end
    
    before(:each) do
      @event = Fabricate(:event)
    end
    
    it 'returns http success' do
      Event.should_receive(:all)
      get :index
      response.should be_success
    end
    
    it 'assigns all events to @events' do
      get :index
      assigns(:events).count.should == 1
      assigns(:events).first.id.should == @event.id
    end
    
  end
  
  describe 'new' do
    it 'assigns a new event to @event' do
      get :new
      assigns(:event).is_a?(Event).should be_true
    end
  end
  
  describe 'edit' do
    before(:each) do
      @event = Fabricate(:event)
    end
    
    it 'assigns the requested event to @event' do
      get :show, :id => @event.id
    end
  end
  
  describe 'show' do
    # before(:each) do
    #   event.message = 'Test Message'
    #   event.service_id = 1
    #   event.status_id = 1
    #   event.save
    # end
    
    before(:each) do
      @event = Fabricate(:event)
    end
    
    it 'assigns the requested event to @event' do
      get :show, :id => @event.id
      # Event.find(:event.id).id.should = @event.id
     
    end
  end
  
  describe 'create' do
    
    context 'with valid message, service_id, and status_id' do
    
      it 'should create a new event' do
        post :create, :event => { :message => 'New Event', :service_id => '1', :status_id => '1' }
        Event.count.should == 1
        Event.last.message.should == 'New Event'
      end    
    
    end
    
  end
  
  describe 'Update event' do
    
    before(:each) do
      @event = Fabricate(:event)
    end
        
    context 'with a valid message' do
      it 'updates the event' do
        put :update, :id => @event, :event => { :message => 'New new event' }
        @event.reload.message.should == 'New new event'
      end
    
    end
  end
  
  describe 'destroy' do
    
    before(:each) do
      @event = Fabricate(:event)
    end
    
    it 'should destroy an event' do
      delete :destroy, :id => @event
      Event.count.should == 0
    end
  end  

end

