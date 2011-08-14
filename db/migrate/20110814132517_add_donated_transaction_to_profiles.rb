class AddDonatedTransactionToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :donated_transaction, :integer, :default => 0
    change_column :profiles, :total_reviews, :integer, :default => 0
    change_column :profiles, :positive_reviews, :integer, :default => 0
    change_column :services, :total_reviews, :integer, :default => 0
    change_column :services, :positive_reviews, :integer, :default => 0
  end

  def self.down
    remove_column :profiles, :donated_transaction
  end
end
