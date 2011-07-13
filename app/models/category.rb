class Category < ActiveRecord::Base
  has_many :service_categories, :dependent => :destroy
  has_many :services, :through => :categories
end
