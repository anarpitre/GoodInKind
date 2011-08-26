class AddNonprofitCountToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :nonprofit_count, :integer, :default => 0
  end

  def self.down
    remove_column :categories, :nonprofit_count
  end
end
