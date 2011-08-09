class CreateServiceNonProfits < ActiveRecord::Migration
  def self.up
    create_table :service_non_profits do |t|
      t.integer :service_id 
      t.integer :non_profit_id
      t.timestamps
    end
  end

  def self.down
    drop_table :service_non_profits
  end
end
