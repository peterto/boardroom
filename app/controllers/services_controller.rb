class ServicesController < ApplicationController
  before_filter :get_service, :only => [:show, :edit, :update, :destroy]
  
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
  end
  
  # GET /services/new
  def new
    @service = Service.new
  end
  
  # GET /service/:id
  def show
  end
  
  # GET /service/:id/edit
  def edit
  end

  # POST /services
  def create
    @service = Service.new(params[:id])
    if @service.save
      redirect_to @service, notice: 'Service was successfully created'
    else
      render action: 'new'
    end
  end

  # PUT /service/:id/
  def update
    if @service.update_attributes(params[:service])
      redirect_to @service, notice: 'Service was succesfully updated'
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
