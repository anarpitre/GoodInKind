class ChangeBookingSeatAndBookingCapacityDefaultZeroToServices < ActiveRecord::Migration
  def self.up
    change_column :services, :booking_capacity, :integer, :default => 0
    change_column :services, :booked_seats, :integer, :default => 0
    change_column :services, :estimated_duration, :integer, :default => 0
  end

  def self.down
  end
end
