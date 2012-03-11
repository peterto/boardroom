class IndexController < ApplicationController
  
  def index
    # Need to check here if the day model needs to be recalculated
    Day.refresh_records if Date.today != Day.get_recent_date
    
    @statuses = Day.get_all_statuses
    @legend_statuses = Status.all
    respond_to do |format|
      format.html
      format.json {
        @statuses = Service.get_events
        render :json => @statuses
      }
    end
  end
  
  def show
    @service = Service.find_by_name(CGI::unescape(params[:service_name]))
    @events = @service.get_all_statuses
  end
  
end