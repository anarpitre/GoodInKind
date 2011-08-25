class AddCategoryIdToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :category_id, :integer
  end

  def self.down
    remove_column :requests, :category_id
  end
end
