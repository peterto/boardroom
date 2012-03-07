class StatusesController < ApplicationController
  prepend_before_filter :get_auth_token
  before_filter :authenticate_admin!
  before_filter :get_all_statuses, :only => [:new, :edit]
  before_filter :get_all_images, :only => [:new, :edit, :create]
  
  def get_all_statuses
    @statuses = Status.all
  end
  
  def get_all_images
    @images = Dir.glob("app/assets/images/*.jpg")
  end
  
  def index
    @statuses = Status.all
      respond_to do |format|
        format.html
        format.json { render :json => @statuses }
      end
  end
  
  def new
    @status = Status.new
  end
  
  def show
    @status = Status.find(params[:id])
  end
  
  def edit
    @status = Status.find(params[:id])
  end
  
  def create
    @status = Status.new(params[:status])
    if @status.save
      redirect_to statuses_path, notice: 'Status was successfully created'
    else
      render action: 'new'
    end
  end
  
  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      redirect_to statuses_path, notice: 'Status was successfully updated'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    redirect_to statuses_url
  end
  
end
