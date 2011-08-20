module ServicesHelper
  def get_nonprofit_name
    @service.nonprofit.try(:name) #blank? ? "" : @service.nonprofit.name
  end

  def get_remaining_spots
    return (@service.booking_capacity.to_i - @service.booked_seats.to_i).to_i
  end

  def get_service_image(size,service)
    unless service.images.first.blank? 
      "#{service.images.first.image.url(size.to_sym)}" 
    else
      "/images/category/#{service.categories.first.image_path}_#{size}.jpg"
    end
  end

end
