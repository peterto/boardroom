class IndexController < ApplicationController
  
  def index
    @statuses = Day.get_all_statuses
    @legend_statuses = Status.all
    respond_to do |format|
      format.html
      format.json {
        @statuses = Service.get_events
        render :json => @statuses }
    end
  end
  
  def show
    @service = Service.find_by_name(CGI::unescape(params[:service_name]))
    @events = @service.get_all_statuses
  end
  
end