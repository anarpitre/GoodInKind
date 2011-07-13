class Category < ActiveRecord::Base

  has_many :non_profit_categories, :dependent => :destory
  has_many :non_profits, :through => :non_profit_categories

  has_many :service_categories, :dependent => :destroy
  has_many :services, :through => :categories
end
