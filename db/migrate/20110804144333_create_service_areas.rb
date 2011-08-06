class CreateServiceAreas < ActiveRecord::Migration
  def self.up
    create_table :service_areas do |t|
      t.string :city
      t.integer :radius
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :service_areas
  end
end
