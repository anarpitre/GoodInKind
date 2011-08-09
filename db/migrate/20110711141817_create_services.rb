class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.integer :booking_capacity
      t.integer :booked_seats
      t.boolean :is_scheduled, :default => true
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :image_id
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
