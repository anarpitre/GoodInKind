class ConfirmationsController < Devise::ConfirmationsController

  def show
    super
    change_service_status unless resource.services.blank?
  end

  def change_service_status
    service = resource.services.first
    service.activate! 
    send_new_service_message(service)
    session[:thank_you] = "yes"
  end

end
