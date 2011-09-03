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
    else
      # address is wrong.
      self.errors.add(:address, "can't be verified")
    end
  end

end
