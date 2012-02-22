class IndexController < ApplicationController
  
  def index
    @statuses = Day.get_all_statuses
  end
  
end