class ServiceNonprofit < ActiveRecord::Base
  belongs_to :service
  belongs_to :nonprofit

  validates :nonprofit_id, :presence => true
end
