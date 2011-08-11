class AddParentNonProfitToNonProfits < ActiveRecord::Migration
  def self.up
    add_column :non_profits, :parent_non_profit, :string
  end

  def self.down
    remove_column :non_profits, :parent_non_profit
  end
end
