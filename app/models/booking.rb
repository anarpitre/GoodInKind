class Booking < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :service
  has_one    :transaction

  before_create :generate_mref

  validates :user, :service, :presence => true

  validates :seats_booked, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => Proc.new {|booking| booking.service.booking_capacity == 0 ? 999 : booking.service.booking_capacity - booking.service.booked_seats}}
  validates :additional_donation_amount, :numericality => { :greater_than_or_equal_to => 0}
  validates :donation_amount, :numericality => { :greater_than_or_equal_to => Proc.new {|booking| booking.service.amount.to_i } }

  # first-giving validations
  validates :billToFirstName, :billToLastName, :remoteAddr, :billToCity, 
            :billToZip, :billToAddressLine1, :accountName, 
            :billToCountry, :billToState, :presence => true
  validates :billToState, :format => { :with => /^\w{2}$/ }
  validates :billToCountry, :format => { :with => /^\w{2,3}$/ } 
  validates :billToEmail, :presence => true

  aasm_column :charge_status
  aasm_initial_state :new

  aasm_state :new  # User created a booking
  aasm_state :processing, :do_enter => :do_processing # Credit Card details captured
  aasm_state :success, :enter => :do_success
  aasm_state :failure, :enter => :do_failure

  aasm_event :cc_captured do
    transitions :to => :processing, :from => :new
  end

  aasm_event :payment_succeeded do
    transitions :to => :success, :from => [:processing, :new]
  end

  aasm_event :payment_failed do
    transitions :to => :failure, :from => [:processing, :new]
  end

  def do_processing
    # TODO: Send email to service offerer about this
    # TODO: Set DelayedJob for this proessing.
  end

  def do_success
    # Send email to offerer, buyer and nonprofit about this
    Notifier.buy_success_offerer(self.service.user.email,self.service.title).deliver
    Notifier.buy_success_buyer(self.user.email,self.service.title).deliver
    Notifier.buy_success_nonprofit(self.service.nonprofit.email,self.service.title).deliver
    calulate_stats_user
    calulate_stats_nonprofit
    calulate_stats_service
  end

  def calulate_stats_user
    #Increment donation amount in offerer
    amount_donated = self.donation_amount + self.additional_donation_amount
    offerer = self.service.user.profile
    calulate_donation_time(service,offerer)
    offerer.donated_amount += amount_donated
    offerer.donated_transaction += 1
    offerer.save

    #Increment purchase amount of Buyer
    buyer = self.user.profile
    buyer.purchase_amount = buyer.purchase_amount.to_i + amount_donated
    buyer.save
  end

  def calulate_stats_service
    service = self.service
    service.booked_seats += 1
    service.total_transactions = service.booked_seats.to_i + 1
    service.save
  end

  def calulate_stats_nonprofit
    nonprofit = self.service.nonprofit
    nonprofit.donated_amount += self.donation_amount + self.additional_donation_amount 
    calulate_donation_time(service,nonprofit)
    nonprofit.total_donors += self.seats_booked
    nonprofit.total_transactions += 1
    nonprofit.save
  end

  def calulate_donation_time(service,entity)
    if service.is_schedulelater 
      entity.donated_time += self.seats_booked * service.estimated_duration 
    else
      entity.donated_time  = service.estimated_duration
    end
  end

  def do_failure
    # Send email to buyer about this
    Notifier.buy_failed_buyer(self.user.email,self.service.title).deliver
  end

  def cardonfile
    self.user.try(:cc_token)
  end

  # This is called from 'delayed job' or directly when an
  # ACTUAL transaction is triggered
  def create_transaction(code, id)
    txn = Transaction.new(:booking => self, :total_amount => self.total_amount)
    if code == 'Success'
      txn.is_success = true
      txn.FG_trnx_id = id
    else
      txn.is_success = false
      txn.failed_reason = id
    end
    txn.save!
  end

  private

  # Mref is the merchant reference. It can be considered as the permalink
  # for all bookings. It is created everytime a user tries to checkout.
  def generate_mref
    self.mref = "#{Date.today.strftime("%Y%m%d")}-#{self.object_id}"
  end
end
