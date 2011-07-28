class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user_id,:uid,:provider, :presence => true  

end
