class SessionsController < Devise::SessionsController
  layout 'home'

  def create
    session[:thank_you] = "yes" unless session[:service_id].blank?
    super
    change_service_offerer(session[:service_id],current_user.id) unless session[:service_id].blank? 
  end


end
