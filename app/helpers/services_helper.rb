module ServicesHelper
  def get_nonprofit_name
    @service.nonprofit.try(:name) #blank? ? "" : @service.nonprofit.name
  end

  def get_remaining_spots
    return (@service.booking_capacity.to_i - @service.booked_seats.to_i).to_i
  end

  def is_buyer(user_id,service_id)
    booking = Booking.success.where(:service_id => service_id, :user_id => user_id).count
    if booking == 0
      return false
    else
      return true
    end
  end

  def review_percentage(service)
    service.user.profile.total_reviews == 0 ? "---" : (service.user.profile.positive_reviews * 100 / service.user.profile.total_reviews).to_i.to_s + "% Positive"
  end

end
