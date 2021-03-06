class HomeController < ApplicationController
  before_filter :set_seo_tags
  layout 'home'

  def index
    @services = Service.active.by_date.by_public.limit(12)
    render :dashboard => (user_signed_in? ? true : false)
  end

  def offer_virtual
    if not params[:invite][:email].blank? || params[:invite][:city].blank?
      Notifier.service_city_request(params[:invite][:email], params[:invite][:city]).deliver
      flash[:notice] = "Invitation sent sucessfully."
    else
      flash[:notice] = "Please enter valid city or email address."
    end
    redirect_to root_path
  end



  def set_seo_tags
    @head = {
      :title => "Support a non-profit cause by simply buying or offering great services",
      #:keywords => "a b c d",
      #:description => 'this is awesome'
    }
  end
end
