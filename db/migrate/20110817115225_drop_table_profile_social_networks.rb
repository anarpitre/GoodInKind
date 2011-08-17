class DropTableProfileSocialNetworks < ActiveRecord::Migration
  def self.up
    drop_table :profile_social_networks
  end

  def self.down
  end
end
