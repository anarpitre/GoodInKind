class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  #validates :address, :latitude, :longitude, :presence => true, :if => Proc.new {|location| location.resource_type == 'User' || (location.resource_type == 'Service' && location.resource.is_virtual == true) }
  validates :address, :latitude, :longitude, :presence => true

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
    end
  end

end
