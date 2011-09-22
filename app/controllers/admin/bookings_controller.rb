class Admin::BookingsController < Admin::AdminBaseController

  def index
    @bookings = Booking.includes([:user => :profile], :service, :transaction).order("created_at DESC")
  end
end
