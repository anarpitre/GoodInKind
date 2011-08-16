class ChangeDonatedTransactionDefaultZeroToProfiles < ActiveRecord::Migration
  def self.up
    change_column :profiles, :donated_transaction, :integer, :default => 0
    change_column :profiles, :is_verified, :boolean, :default => false
  end

  def self.down
  end
end
