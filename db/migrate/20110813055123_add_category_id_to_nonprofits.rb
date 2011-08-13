class AddCategoryIdToNonprofits < ActiveRecord::Migration
  def self.up
    add_column :nonprofits, :category_id, :integer
  end

  def self.down
    remove_column :nonprofits, :category_id
  end
end
