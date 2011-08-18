module ServicesHelper
  def get_nonprofit_name
    @service.nonprofit.try(:name) #blank? ? "" : @service.nonprofit.name
  end

  def get_remaining_spots
    return (@service.booking_capacity.to_i - @service.booked_seats.to_i).to_i
  end

end
