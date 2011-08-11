class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.integer :service_id
      t.integer :user_id
      t.integer :seats_booked
      t.date :charge_on_date
      t.string :charge_status
      t.string :cardonfile_id
      t.float :donation_amount
      t.float :additional_donation_amount
      t.float :CC_charges
      t.float :GIK_charges
      t.float :total_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
