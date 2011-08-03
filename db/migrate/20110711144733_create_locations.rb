class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip
      t.references :resource, :polymorphic => true
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
