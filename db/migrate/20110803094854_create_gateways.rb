class CreateGateways < ActiveRecord::Migration
  def self.up
    create_table :gateways do |t|
      t.string  :gateway_name
      t.timestamps
    end
  end

  def self.down
    drop_table :gateways
  end
end
