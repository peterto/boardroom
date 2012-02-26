class IndexController < ApplicationController
  
  def index
    @statuses = Day.get_all_statuses
    @legend_statuses = Status.all
  end
  
end