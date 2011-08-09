class ServiceNonProfit < ActiveRecord::Base
  belongs_to :service
  belongs_to :non_profit

  validates :non_profit_id, :presence => true
end
