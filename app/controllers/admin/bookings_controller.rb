class Admin::BookingsController < Admin::AdminBaseController

  def index
    @bookings = Booking.includes([:user => :profile], :service, :transaction).order("created_at DESC")
    @bookings = @bookings.paginate(:per_page => 20, :page => params[:page] )
    respond_to do |format|
      format.html 
      format.js
    end
  end
end
