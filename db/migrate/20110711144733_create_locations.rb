class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :locality
      t.string :city
      t.string :state
      t.string :country
      t.references :resource, :polymorphic => true
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
