class IndexController < ApplicationController
  
  def index
    @statuses = Day.get_all_statuses
    @legend_statuses = Status.all
    respond_to do |format|
      format.html
      format.json { render :json => @statuses }
    end
  end
  
end