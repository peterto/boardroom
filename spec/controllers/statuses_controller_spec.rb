require 'spec_helper'

describe StatusesController do
  
  before(:each) do
    login_user
  end
  
  describe 'index' do
    
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
      get :edit, :id => @status.id
    end
  end
  
  # describe 'show' do
  #   
  #   before(:each) do
  #     @status = Fabricate(:status)
  #   end
  #   
  #   it 'assigns the requested status to @status' do
  #     get :show, :id => @status.id
  #     # Status.find(:status.id).id.should = @status.id
  #   end
  # end
  
  describe 'create' do
    
    context 'with valid name, service_id, and status_id' do
    
      it 'should create a new status' do
        post :create, :status => { :name => 'New Status', :image => 'New Status image', :description => 'New Description'}
        Status.count.should == 1
        Status.last.name.should == 'New Status'
        Status.last.image.should == 'New Status image'
      end    
    
    end
    
  end
  
  describe 'Update status' do
    
    before(:each) do
      @status = Fabricate(:status)
    end
        
    context 'with a valid name' do
      it 'updates the status' do
        put :update, :id => @status, :status => { :name => 'New new status' }
        @status.reload.name.should == 'New new status'
      end
    end
    
    context 'with a valid image' do
      it 'updates the status' do
        put :update, :id => @status, :status => { :image => 'New new image' }
        @status.reload.image.should == 'New new image'
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
