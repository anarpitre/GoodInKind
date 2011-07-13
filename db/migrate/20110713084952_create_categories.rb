class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :category_type #Category type are (1 = "Service or experience categories") and (2="Cause Categories")
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
