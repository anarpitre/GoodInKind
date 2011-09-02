class Category < ActiveRecord::Base
  has_many :service_categories
  has_many :services, :through => :service_categories

  has_many :nonprofit_categories
  has_many :nonprofits, :through => :nonprofit_categories

  has_many :requests

  default_scope :order => 'name'
  scope :by_services, where(:category_type => SERVICE) 
  scope :by_category_count, where("service_count > ?", 0) 
  scope :by_nonprofits, where(:category_type =>  NONPROFIT) 
  scope :by_nonprofits_category_count, where("nonprofit_count > ?", 0) 

end
