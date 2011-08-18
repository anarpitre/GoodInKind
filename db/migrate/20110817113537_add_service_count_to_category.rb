class AddServiceCountToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :service_count, :integer, :default => 0
  end

  def self.down
    remove_column :categories, :service_count
  end
end
