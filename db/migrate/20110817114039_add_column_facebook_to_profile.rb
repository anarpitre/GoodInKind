class AddColumnFacebookToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :facebook, :string
    add_column :profiles, :twitter, :string
    add_column :profiles, :linkedin, :string

    change_column :profiles, :is_verified, :boolean, :default => true
  end

  def self.down
    remove_column :profiles, :facebook
    remove_column :profiles, :twitter
    remove_column :profiles, :linkedin

    remove_column :profiles, :is_verified
  end
end
