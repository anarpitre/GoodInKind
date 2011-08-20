class AddEmailOptionsInProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :email_takemyservice, :boolean, :default => true
    add_column :profiles, :email_addmessage, :boolean, :default => true
    add_column :profiles, :email_addreview, :boolean, :default => true
    add_column :profiles, :email_paid, :boolean, :default => true
    add_column :profiles, :email_cancel, :boolean, :default => true
    add_column :profiles, :email_itakeservice, :boolean, :default => true
    add_column :profiles, :email_remindpayment, :boolean, :default => true
  end

  def self.down
    remove_column :profiles, :email_takemyservice
    remove_column :profiles, :email_addmessage
    remove_column :profiles, :email_addreview
    remove_column :profiles, :email_paid
    remove_column :profiles, :email_cancel
    remove_column :profiles, :email_itakeservice
    remove_column :profiles, :email_remindpayment
  end
end
