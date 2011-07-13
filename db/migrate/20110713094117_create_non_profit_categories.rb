class CreateNonProfitCategories < ActiveRecord::Migration
  def self.up
    create_table :non_profit_categories do |t|
      
      t.references :non_profit
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :non_profit_categories
  end
end
