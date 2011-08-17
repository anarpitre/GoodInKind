class AddColumnPermalinkService < ActiveRecord::Migration
  def self.up
    add_column :services, :permalink, :string
  end

  def self.down
    remove_column :services, :permalink
  end
end
