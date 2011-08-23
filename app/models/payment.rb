class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :service

  before_create :set_defaults

  def set_defaults
    self.status = 'created'
  end
end
