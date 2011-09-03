class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'home'
  include ApplicationHelper
  
  def after_sign_in_path_for(scope)
    if session[:thank_you] == "yes"
      session[:thank_you] = nil
      thankyou_services_path
    else
      services_path(current_user)
    end
  end

  # If a non-signed-in user creates service then a temporary_id is stored as user_id.After signing-in or registering the temprary_id is changed to
  # signed-in/registered  user_id
  def change_service_offerer(service_id,user_id)
    service = Service.find(service_id)
    service.user_id = user_id
    service.save
    service.activate! 
    session[:service_id] = nil
  end

  def get_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
end
