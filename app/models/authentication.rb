class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid,:provider, :presence => true  

end
