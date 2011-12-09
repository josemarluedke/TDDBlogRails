class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def user_logged?
    if session[:user_id]; true; elsif false; end
  end
  
  def user_unloggend!
    render "common/not_logged", :status => 404
  end
  
  def not_found
    render "common/not_found", :status => 404
  end
end
