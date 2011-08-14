class AddImagePathToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :image_path, :string
  end

  def self.down
    remove_column :categories, :image_path
  end
end
