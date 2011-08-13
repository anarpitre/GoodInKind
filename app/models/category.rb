class Category < ActiveRecord::Base
  has_many :services, :through => :service_categories
  has_many :nonprofits, :through => :nonprofit_categories

  scope :get_service_category, where("category_type = ?", SERVICE) 
  scope :by_nonprofits, where("category_type = ?", NONPROFIT) 

end
