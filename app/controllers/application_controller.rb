class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'home'
  include ApplicationHelper
  
  def after_sign_in_path_for(scope)
    if session[:thank_you] == "yes"
      session[:thank_you] = nil
      thankyou_services_path
    elsif is_admin?
      nonprofits_path
    else
      services_path
    end
  end

  # If a non-signed-in user creates service then a temporary_id is stored as user_id.After signing-in or registering the temprary_id is changed to
  # signed-in/registered  user_id
  def change_service_offerer(service_id,user_id)
    service = Service.find(service_id)
    service.user_id = user_id
    service.save
    service.activate! 
    send_new_service_message(service)
    session[:service_id] = nil
  end

  def send_new_service_message(service)
    Notifier.new_service_admin(service.id,current_user.profile.first_name,current_user.profile.last_name).deliver
    Notifier.new_service_offerer(service.id,current_user.email).deliver
    Notifier.new_service_nonprofit(service.id,current_user.profile.first_name,current_user.profile.last_name,current_user.profile.hide_email,current_user.email,service.nonprofit.email,service.nonprofit.name).deliver
  end

  def get_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end

  def is_owner
    unless @user == current_user
      flash[:notice] = "You do not have sufficent privileges."
      redirect_to profile_path(@user) 
    end    
  end
end
