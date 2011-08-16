class DropTableResourceCategory < ActiveRecord::Migration
  def self.up
    drop_table :resource_categories
  end
end
