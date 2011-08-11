class Booking < ActiveRecord::Base
 
  belongs_to :services
  has_one    :transaction

end
