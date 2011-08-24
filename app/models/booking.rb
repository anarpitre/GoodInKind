class Booking < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :service
  has_one    :transaction

  before_create :generate_mref

  aasm_column :charge_status
  aasm_initial_state :new

  aasm_state :new  # User created a booking
  aasm_state :processing, :do_enter => :do_processing # Credit Card details captured
  aasm_state :success, :do_enter => :do_success
  aasm_state :failure, :do_enter => :do_failure


  aasm_event :cc_captured do
    transitions :to => :processing, :from => :new
  end

  aasm_event :payment_succeeded do
    transitions :to => :success, :from => :processing
  end

  aasm_event :payment_failed do
    transitions :to => :failure, :from => :processing
  end

  def do_processing
    # TODO: Send email to service offerer about this
    # TODO: Set DelayedJob for this proessing.
  end

  def do_success
    # Send email to user and service offerer about this
  end

  def do_failure
    # Send email to user and service offerer about this
  end

  private

  # Mref is the merchant reference. It can be considered as the permalink
  # for all bookings. It is created everytime a user tries to checkout.
  def generate_mref
    self.mref = "#{Date.today.strftime("%Y%m%d")}-#{self.object_id}"
  end
end
