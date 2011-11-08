class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'home'
  include ApplicationHelper
  
  def after_sign_in_path_for(scope)
    if session[:thank_you] == 'yes'
      session[:thank_you] = nil
      thankyou_services_path
    elsif session[:message_to] != nil
      new_message_path(:id => session[:message_to])
      session[:message_to] = nil
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
    unless current_user.blank? 
      service.activate! 
      send_new_service_message(service)
    end
    session[:service_id] = nil
  end

  def send_new_service_message(service)
    Notifier.new_service_admin(service.id,current_user.profile.full_name,service.is_public).deliver
    Notifier.new_service_offerer(service.id,current_user.email).deliver
    Notifier.new_service_nonprofit(service.id,current_user.profile.full_name,current_user.profile.hide_email,current_user.email,service.nonprofit.email,service.nonprofit.name).deliver
    unless service.request_id.blank?
      request = Request.find(service.request_id)
      Notifier.new_service_request(service.id,request.title,request.email).deliver
    end
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
