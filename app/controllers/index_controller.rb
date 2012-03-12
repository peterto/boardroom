class IndexController < ApplicationController
  
  def index
    @legend_statuses = Status.all
    
    unless Service.all.count == 0
      # Need to check here if the day model needs to be recalculated ONLY if there is already a service
      Day.refresh_records if Date.today != Day.get_recent_date
      
      @statuses = Day.get_all_statuses
      respond_to do |format|
        format.html
        format.json {
          render :json => @statuses
        }
        format.json { render :json => @statuses }
      end
    end
  end
  
  def show
    @service = Service.find_by_name(CGI::unescape(params[:service_name]))
    @events = @service.get_all_statuses
      respond_to do |format|
        format.html
        format.json { render :json => @statuses } 
      end
  end
  
end