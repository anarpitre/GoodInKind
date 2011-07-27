class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  validates :address,:unless => Proc.new { |t| t.resource.class.name == 'Service' and t.resource.is_virtual == true },:presence => true  
  #validates :address,:latitude,:longitude,:unless => Proc.new { |t| t.resource.class.name == 'Service' and t.resource.is_virtual == true },:presence => true  
  #validates :address,:unless => Proc.new { |t| t.resource.class.name == 'Service' and t.resource.is_virtual == true },:presence => true  

  #geocoded_by :full_address
  before_validation :full_address
  #before_update :full_address


  def full_address
    geo = Geocoder.search(self.address)
    if geo && geo.first 
      geo = geo.first
      self.city = geo.city
      #State name is under the name of administrative_area_level_1 in hash result
      count = 0
      geo.data["address_components"].size.times do 
        if geo.data["address_components"][count]["types"][0] == "administrative_area_level_1"
          self.state =  geo.data["address_components"][count]["short_name"]
        end
        count += 1
      end
      self.country = geo.country_code
      self.address= geo.formatted_address
    end
  end

  #after_validation :geocode # auto-fetch coordinates

end
