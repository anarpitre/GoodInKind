class AddPermalinkToService < ActiveRecord::Migration
  def self.up
    add_column :services, :permalink, :string
    add_index :services, :permalink
  end
  def self.down
    remove_column :services, :permalink
  end
end