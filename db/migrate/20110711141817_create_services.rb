class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.integer :booking_capacity
      t.integer :booked_seats
      t.boolean :is_scheduled, :default => true
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :group_number
      t.float :non_profit_percentage
      t.boolean :is_virtual, :default => true
      t.boolean :is_public,  :default => true
      t.integer :estimated_duration
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
