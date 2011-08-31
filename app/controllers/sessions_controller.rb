class SessionsController < Devise::SessionsController
  before_filter :set_seo_tags
  layout 'signup'

  def new
    @head[:title] = "SignIn"
    @class_name = 'sign_up'
    super
  end
  
  def create
    @class_name = 'sign_up'
    session[:thank_you] = "yes" unless session[:service_id].blank?
    super
    change_service_offerer(session[:service_id],current_user.id) unless session[:service_id].blank? 
  end

  private


  def set_seo_tags
    @head = {
      :title => "SignIn",
      :keywords => "x y z",
      :description => 'This really works'
    }
  end


end
