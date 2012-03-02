class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| 
  c.request.format == 'application/json' }
  
  private
  def get_auth_token
     if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
         params[:auth_token] = auth_token
     end
  end
end