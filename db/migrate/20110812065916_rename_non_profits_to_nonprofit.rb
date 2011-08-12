class RenameNonProfitsToNonprofit < ActiveRecord::Migration
  def self.up
    rename_table :non_profits, :nonprofits
    rename_table :non_profit_categories, :nonprofit_categories
    rename_table :service_non_profits, :service_nonprofits

    rename_column :service_nonprofits, :non_profit_id, :nonprofit_id
    rename_column :services, :non_profit_percentage, :nonprofit_percentage
    rename_column :services, :non_profit_id, :nonprofit_id
    rename_column :nonprofit_categories, :non_profit_id, :nonprofit_id
    rename_column :nonprofits, :parent_non_profit, :parent_nonprofit
  end

  def self.down
    rename_table :nonprofits, :non_profits
    rename_table :nonprofit_categories, :non_profit_categories
    rename_table :service_nonprofits, :service_non_profits

    rename_column :service_non_profits, :nonprofit_id, :non_profit_id
    rename_column :services, :nonprofit_percentage, :non_profit_percentage
    rename_column :services, :nonprofit_id, :non_profit_id
    rename_column :non_profit_categories, :nonprofit_id, :non_profit_id
    rename_column :non_profits, :parent_nonprofit, :parent_non_profit
  end
end
