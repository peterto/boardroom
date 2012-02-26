require 'spec_helper'

describe EventsController do
  
  before(:each) do
    @service = Fabricate(:service)
    @event = Fabricate(:event, :service_id => @service.id)
    4.times do |i|
      Fabricate(:status, :id => i)
    end
  end
  
  describe 'index' do
    
    it 'returns http success' do
      get :index, :service_id => @service.id
      response.should be_success
    end
    
    it 'assigns all events of a service to @events' do
      get :index, :service_id => @service.id
      assigns(:service).should == @service
      assigns(:events).count.should == 1
      assigns(:events).first.id.should == @event.id
    end
    
  end
  
  describe 'new' do
    it 'assigns a new event to @event' do
      get :new, :service_id => @service.id
      assigns(:event).is_a?(Event).should be_true
    end
  end
  
  describe 'show' do    
    it 'assigns the requested event to @event' do
      get :show, :service_id => @service.id, :id => @event.id
      assigns(:event).should == @event
    end
  end
  
  describe 'create' do
    context 'with valid message, service_id, and status_id' do
      it 'should create a new event' do
        post :create, :service_id => 1, :event => { :message => 'New Event', :service_id => 1, :status_id => 1 }
        Event.count.should == 2
        Event.last.message.should == 'New Event'
      end
    end
  end
  
  describe 'destroy' do
    it 'should destroy an event' do
      delete :destroy, :id => @event
      Event.count.should == 0
    end
  end
end