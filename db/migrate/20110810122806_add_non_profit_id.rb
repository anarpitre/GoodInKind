class AddNonProfitId < ActiveRecord::Migration
  def self.up
    change_table :services do |t|
      t.references :non_profit
    end
  end

  def self.down
    remove_column :services, :non_profit_id
  end
end
