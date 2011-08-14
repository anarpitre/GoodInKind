class ConfirmationsController < Devise::ConfirmationsController

  def create
    super
    change_service_status unless resource.services.blank?
  end

  def change_service_status
    self.activate! 
    session[:thank_you] = "yes"
  end

end
