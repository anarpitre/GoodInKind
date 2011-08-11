class AddDonatedAmountAndDonatedTimeToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :donated_amount, :float, :default => 0
    add_column :profiles, :donated_time, :integer, :default => 0
  end

  def self.down
    remove_column :profiles, :donated_time
    remove_column :profiles, :donated_amount
  end
end
