class CreateSocialNetworks < ActiveRecord::Migration
  def self.up
    create_table :social_networks do |t|
      t.string :name
      t.string :site_url
      t.string :token
      t.string :key
      t.string :code
      t.timestamps
    end
  end

  def self.down
    drop_table :social_networks
  end
end
