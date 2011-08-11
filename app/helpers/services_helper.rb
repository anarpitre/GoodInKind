module ServicesHelper
  def get_non_profit_name
    return @service.non_profit.blank? ? "" : @service.non_profit.name
  end

  def get_remaining_spots
    return (@service.booking_capacity.to_i - @service.booked_seats.to_i).to_i
  end
end
