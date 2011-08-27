class AddIndexEinToNonprofits < ActiveRecord::Migration
  def self.up
    add_index :nonprofits, :EIN, :unique => true
  end

  def self.down
    remove_index :nonprofits, :EIN
  end
end
