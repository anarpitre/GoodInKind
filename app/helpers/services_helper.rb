module ServicesHelper
  def get_non_profit_name
    @service.non_profit.try(:name) #blank? ? "" : @service.non_profit.name
  end

  def get_remaining_spots
    return (@service.booking_capacity.to_i - @service.booked_seats.to_i).to_i
  end
end
