class Location < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  
  validates :locality,:city,:state,:country,:email, :phone,:presence => true  
  #validates :email, :uniquness => true#, :email_format => true
end
