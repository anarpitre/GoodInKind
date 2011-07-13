class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.integer :booking_capacity
      t.integer :booked_seat
      t.boolean :is_scheduled
      t.integer :offerer_id
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
      t.integer :non_profit_id
      t.float :non_profit_percentage
      t.boolean :is_virtual
      t.boolean :is_public
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
