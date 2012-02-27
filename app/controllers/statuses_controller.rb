class StatusesController < ApplicationController
 before_filter :authenticate_admin!
  def index
    @statuses = Status.all
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
      redirect_to @status, notice: 'Status was successfully created'
    else
      render action: 'new'
    end
  end
  
  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      redirect_to @status, notice: 'Status was successfully updated'
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
