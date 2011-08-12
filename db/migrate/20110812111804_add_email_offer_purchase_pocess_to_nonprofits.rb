class AddEmailOfferPurchasePocessToNonprofits < ActiveRecord::Migration
  def self.up
    add_column :nonprofits, :email_offer, :boolean, :default => false
    add_column :nonprofits, :email_purchase, :boolean, :default => false
    add_column :nonprofits, :email_process, :boolean, :default => false
  end

  def self.down
    remove_column :nonprofits, :email_process
    remove_column :nonprofits, :email_purchase
    remove_column :nonprofits, :email_offer
  end
end
