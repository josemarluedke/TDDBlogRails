class UsersController < ApplicationController
  def index
    return user_unloggend! unless user_logged?
    @users = User.all
  end

  def show
    (@user = User.find_by_id params[:id]) || (return not_found)
  end

  def login
    
  end
  
  def destroy
    return user_unloggend! unless user_logged?
    user = User.find_by_id params[:id]
    user.destroy
    
    redirect_to users_url
  end
end
