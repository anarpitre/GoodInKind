class AddDonatedAmountTimeTransactionDonorToNonprofits < ActiveRecord::Migration
  def self.up
    add_column :nonprofits, :donated_amount, :integer, :default => 0
    add_column :nonprofits, :donated_time, :integer, :default => 0
    add_column :nonprofits, :total_donors, :integer, :default => 0
    add_column :nonprofits, :total_transactions, :integer, :default => 0
  end

  def self.down
    remove_column :nonprofits, :total_transactions
    remove_column :nonprofits, :total_donors
    remove_column :nonprofits, :donated_time
    remove_column :nonprofits, :donated_amount
  end
end
