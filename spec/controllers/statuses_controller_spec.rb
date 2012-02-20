require 'spec_helper'

describe StatusesController do

  # let(:status) { Status.new }
  
  describe 'index' do
    
    # before(:each) do
    #   status.message = 'Test Message'
    #   status.service_id = 1
    #   status.status_id = 1
    #   status.save
    # end
    
    before(:each) do
      @status = Fabricate(:status)
    end
    
    it 'returns http success' do
      Status.should_receive(:all)
      get :index
      response.should be_success
    end
    
  end
  
  describe 'new' do
    it 'assigns a new status to @status' do
      get :new
      assigns(:status).is_a?(Status).should be_true
    end
  end
  
  describe 'edit' do
    before(:each) do
      @status = Fabricate(:status)
    end
    
    it 'assigns the requested status to @status' do
      get :show, :id => @status.id
    end
  end
  
  describe 'show' do
    
    before(:each) do
      @status = Fabricate(:status)
    end
    
    it 'assigns the requested status to @status' do
      get :show, :id => @status.id
      # Status.find(:status.id).id.should = @status.id
     
    end
  end
  
  describe 'create' do
    
    context 'with valid name, service_id, and status_id' do
    
      it 'should create a new status' do
        post :create, :id => { :name => 'New Status', :image => 'New Status image'}
        Status.count.should == 1
        Status.last.name.should == 'New Status'
      end    
    
    end
    
  end
  
  describe 'Update status' do
    
    before(:each) do
      @status = Fabricate(:status)
    end
        
    context 'with a valid message' do
      it 'updates the status' do
        put :update, :id => @status, :status => { :name => 'New new status' }
        @status.reload.name.should == 'New new status'
      end
    
    end
  end
  
  describe 'destroy' do
    
    before(:each) do
      @status = Fabricate(:status)
    end
    
    it 'should destroy an status' do
      delete :destroy, :id => @status
      Status.count.should == 0
    end
  end
end
