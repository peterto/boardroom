class EventsController < ApplicationController
  before_filter :get_service
  before_filter :authenticate_admin!, :except => :show
  
  def get_service
    begin
      @service = Service.find(params[:service_id])
    rescue ActiveRecord::RecordNotFound
      render file: "public/404.html", status: 404
    end
  end
  
  def index
    @events = @service.get_all_statuses
  end
  
  def new
    @event = Event.new
  end
  
  def show
    @event = Event.find(params[:id])
  end
 
  
  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      format.html {
        if @event.save
          redirect_to service_events_path(@service), notice: 'Event was successfully created'
        else
          render action: 'new'
        end 
      }
      format.json {
        if @event.save 
          render :json => @event 
        else
          render :json => @event.errors  
        end 
      }
    end
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to service_events_path(@service)
  end
end
