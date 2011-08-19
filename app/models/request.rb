class Request < ActiveRecord::Base
  include AASM

  has_one :service
  has_one :location, :as => :resource,:dependent => :destroy

  validates :title, :description, :email, :presence => true
  validates :email,  :presence => true, :format => EMAIL_REGEX
  
  accepts_nested_attributes_for :location, :reject_if => :all_blank, :allow_destroy => true
  
  ###  AASM transition ###
  aasm_column :status
  aasm_initial_state :created

  aasm_state :created
  aasm_state :offered, :enter => :request_offered
  aasm_state :rejected, :enter => :request_rejected

  aasm_event :offered do
    transitions :to => :offered, :from => [:created]
  end

  aasm_event :reject! do
    transitions :to => :rejected, :from => [:created]
  end

  def request_offered
    # FIXME: request is offered email notification
  end

  def request_rejected
    # FIXME: request rejection email notification
  end

end
