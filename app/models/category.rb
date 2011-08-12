class Category < ActiveRecord::Base
  has_many :resource_categories, :dependent => :destroy
  has_many :services, :through => :resource_categories
  has_many :nonprofits, :through => :resource_categories

  scope :get_service_category, where("category_type = ?",SERVICE) 

end
