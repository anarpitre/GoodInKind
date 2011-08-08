class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  validates :address, :latitude, :longitude, :presence => true

  before_validation :full_address


  def full_address
    geo = Geocoder.search(self.address)
    if geo && geo.first 
      geo = geo.first
      self.city = geo.city
      #State name is under the name of administrative_area_level_1 in hash result
      # FIXME: Why are we iterating if we are always setting the state -- this is wrong! 
      count = 0
      geo.data["address_components"].size.times do 
        if geo.data["address_components"][count]["types"][0] == "administrative_area_level_1"
          self.state =  geo.data["address_components"][count]["short_name"]
        end
        count += 1
      end
      self.country = geo.country_code
      self.address= geo.formatted_address
      self.zip = geo.postal_code
      self.latitude = geo.latitude
      self.longitude = geo.longitude
    end
  end

end
