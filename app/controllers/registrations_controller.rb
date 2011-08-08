class RegistrationsController < Devise::RegistrationsController
  before_filter :set_seo_tags
  layout 'signup'

  def new
    @head[:title] = 'Sign Up'
    super
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
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
