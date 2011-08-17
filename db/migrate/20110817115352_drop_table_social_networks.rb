class DropTableSocialNetworks < ActiveRecord::Migration
  def self.up
    drop_table :social_networks
  end

  def self.down
  end
end
