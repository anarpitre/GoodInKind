class ChangeEmailOptionsDefaultInNonprofits < ActiveRecord::Migration
  def self.up
    change_column :nonprofits, :email_offer, :boolean, :default => true
    change_column :nonprofits, :email_purchase, :boolean, :default => true
    change_column :nonprofits, :email_process, :boolean, :default => true
  end

  def self.down
  end
end
