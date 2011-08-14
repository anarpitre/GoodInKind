class RegistrationsController < Devise::RegistrationsController
  before_filter :set_seo_tags
  layout 'signup'

  def new
    @head[:title] = 'Sign Up'
    super
  end

  def create
    session[:thank_you] = "yes" unless session[:service_id].blank?
    super
    session[:omniauth] = nil unless @user.new_record?
    change_service_offerer(session[:service_id],resource.id) unless session[:service_id].blank? 
  end
  
  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def set_seo_tags
    @head = {
      :title => "Regsitration",
      :keywords => "x y z",
      :description => 'This really works'
    }
  end

end
