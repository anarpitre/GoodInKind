class NonProfitCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :non_profit

  validates :non_profit_id , :presence => true
  validates :category_id, :presence => true
end
