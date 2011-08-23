class Category < ActiveRecord::Base
  has_many :service_categories
  has_many :services, :through => :service_categories

  has_many :nonprofit_categories
  has_many :nonprofits, :through => :nonprofit_categories

  has_many :requests

  scope :by_services, where(:category_type => SERVICE) 
  scope :by_nonprofits, where(:category_type =>  NONPROFIT) 

end
