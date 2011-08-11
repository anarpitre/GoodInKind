class Category < ActiveRecord::Base
  has_many :resource_categories, :dependent => :destroy
  has_many :services, :through => :resource_categories
  has_many :non_profits, :through => :resource_categories
end
