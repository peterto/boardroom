require 'spec_helper'

describe ServicesController do
  
  before(:each) do
    login_user
  end

  describe "GET index" do
    
    before(:each) do
      @service = Fabricate(:service)

    end
    
    it "assigns all services to @services" do
      get :index
      assigns(:services).count.should == 1
      assigns(:services).first.id.should == @service.id
    end
  
  end
  describe "GET new" do
    it "assigns a new service to @service" do
      get :new
      assigns(:service).is_a?(Service).should be_true
    end
  end
  
  describe "GET edit" do
    
    before(:each) do
      @service = Fabricate(:service)
    end
  
    it "assigns the requested service to @service" do
      get :edit, :id => @service.id.to_s
      assigns(:service).id.should == @service.id
    end
  end
  
  describe "POST create" do
    
    describe "with valid params" do
    
      it "creates a new service" do
        post :create, :service => { :name => "New Service" }
        Service.count.should == 1
        Service.last.name.should == "New Service"
        response.should redirect_to(services_url)
      end
    end
    
    describe "with invalid params" do
      it "does not create a new service" do
        post :create, :service => { :name => "" }
        Service.count.should == 0
      end
    end
  end
  
  describe "PUT update" do
    
    before(:each) do
      @service = Fabricate(:service)
    end
    
    describe "with valid params" do
        
      it "updates the service" do
        put :update, :id => @service, :service => { :name => "New Name" }
        @service.reload.name.should == "New Name"
      end
    end
    
    describe "with invalid params" do
      it "does not update the service" do
        old_name = @service.name
        put :update, :id => @service, :service => { :name => '' }
        @service.reload.name.should == old_name
      end
    end
  end
  
  describe "DELETE destroy" do
    
    before(:each) do
      @service = Fabricate(:service)
    end
    
    it "destroys the service" do
      delete :destroy, :id => @service
      Service.count.should == 0
    end
  end
end
      
    