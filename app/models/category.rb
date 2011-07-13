class Category < ActiveRecord::Base

  has_many :non_profit_categories
  has_many :non_profits, :through => :non_profit_categories

end
