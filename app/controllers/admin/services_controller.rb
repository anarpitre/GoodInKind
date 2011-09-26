class Admin::ServicesController < Admin::AdminBaseController

  def index
    @services = Service.unscoped.includes(:nonprofit, :user => :profile).order("title")
  end

  def show
    @service = Service.includes(:user => :profile).find(params[:id])
  end

 def transaction
    @service = Service.includes(:user => :profile).find(params[:id])
    @bookings = @service.bookings.includes(:service, :user => :profile)
 end

  def destroy
    @service = Service.find(params[:id])
    @service.remove!
    redirect_to admin_services_path
  end

end
