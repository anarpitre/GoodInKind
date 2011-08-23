class PaymentToken < ActiveRecord::Base
  belongs_to :user

  def process_payment
  end
end
