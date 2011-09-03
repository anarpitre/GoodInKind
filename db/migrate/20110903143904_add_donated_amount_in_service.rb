class AddDonatedAmountInService < ActiveRecord::Migration
  def self.up
    add_column :services, :donated_amount, :integer
    add_column :services, :total_transactions, :integer
  end

  def self.down
    remove_column :services, :donated_amount
    remove_column :services, :total_transactions
  end
end
