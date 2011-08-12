class NonprofitCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :nonprofit

  validates :nonprofit_id , :presence => true
  validates :category_id, :presence => true
end
