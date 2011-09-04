class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  # Any way We will verify the address so no need to check the presence
  #validates :address, :presence => true
  before_validation :full_address

  def full_address
    geo = Geocoder.search(self.address)
    if geo && geo.first
      geo = geo.first
      self.city = geo.city
      self.state = geo.state
      self.country = geo.country_code
      self.address= geo.formatted_address
      self.zip = geo.postal_code
      self.latitude = geo.latitude
      self.longitude = geo.longitude
      if self.resource_type == "Service"
        unless check_distance
          self.errors.add(:address, "At present service not provided at this location")
        end
      end
    else
      # address is wrong.
      self.errors.add(:address, "can't be verified")
    end
  end

  def check_distance
    service_area = ServiceArea.all
    service_area.each {|s| 
      point1 = [s.latitude,s.longitude]
      point2 = [self.latitude,self.longitude]
      begin
        dist = Geocoder::Calculations.distance_between(point1, point2)
        if dist <= s.radius 
          return true
        end
      rescue
        return false
      end
    }
    return false
  end
end
