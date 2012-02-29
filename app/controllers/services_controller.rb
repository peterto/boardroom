class ServicesController < ApplicationController
  before_filter :get_service, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  def get_service
    begin
      @service = Service.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404.html", status: 404
    end
  end
  
  # GET /services
  def index
    @services = Service.all
    respond_to do |format|
      format.html
      format.json { 
        @services = @services.collect(&:name)
        render :json => @services  }
    end
  end
  
  # GET /services/new
  def new
    @service = Service.new
  end
  
  # GET /service/:id
  def show
    @service = Service.find(params[:id])
  end
  
  # GET /service/:id/edit
  def edit
  end

  # POST /services
  def create
    @service = Service.new(params[:service])
    respond_to do |format|
      format.html {
        if @service.save
          redirect_to services_path, notice: 'Service was successfully created'
        else
          render action: 'new'
        end } 
      format.json  if @service.save { render :json => @service }  
    end
  end

  # PUT /service/:id/
  def update
    if @service.update_attributes(params[:service])
      redirect_to services_path, notice: 'Service was succesfully updated'
    else
      render action: 'edit'
    end
  end
  
  # DELETE /service/:id
  def destroy
    @service.destroy
    redirect_to services_url
  end
end
