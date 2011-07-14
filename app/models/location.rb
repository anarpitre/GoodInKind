class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  
  validates :locality,:city,:state,:country,:presence => true  
  #validates :email, :uniquness => true#, :email_format => true
end
