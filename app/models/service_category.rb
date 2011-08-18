class ServiceCategory < ActiveRecord::Base
  belongs_to :service
  belongs_to :category, :counter_cache => :service_count
end
