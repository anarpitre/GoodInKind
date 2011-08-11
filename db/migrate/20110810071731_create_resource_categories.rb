class CreateResourceCategories < ActiveRecord::Migration
  def self.up
    create_table :resource_categories do |t|
      t.references :resource, :polymorphic => true
      t.references :category
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_categories
  end
end
