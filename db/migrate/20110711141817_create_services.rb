class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :title
      t.text :description
      t.float :amount
      t.integer :booking_capacity
      t.boolean :is_scheduled
      t.integer :offerer_id
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
      t.integer :charity_id
      t.float :charity_percentage
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.boolean :priority
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
