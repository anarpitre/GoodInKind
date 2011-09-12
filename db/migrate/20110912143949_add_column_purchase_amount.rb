class AddColumnPurchaseAmount < ActiveRecord::Migration
  def self.up
    add_column :profiles, :purchase_amount, :float, :default => 0
  end

  def self.down
    remove_column :profiles, :purchase_amount
  end
end
