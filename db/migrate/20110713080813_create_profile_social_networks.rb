class CreateProfileSocialNetworks < ActiveRecord::Migration
  def self.up
    create_table :profile_social_networks do |t|
      t.integer :profile_id
      t.integer :social_network_id
      t.string :user_url

      t.timestamps
    end
  end

  def self.down
    drop_table :profile_social_networks
  end
end
