class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  
  validates :locality,:city,:state,:country,:presence => true  
end
