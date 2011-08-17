class DropColumnNonProfitPercentageFromServices < ActiveRecord::Migration
  def self.up
    remove_column :services, :nonprofit_percentage
  end

  def self.down
    add_column :services, :nonprofit_percentage, :float
  end
end
