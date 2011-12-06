class AddTipamountToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :tipamount, :float, :default => 0.0
  end

  def self.down
    remove_column :services, :tipamount
  end
end
