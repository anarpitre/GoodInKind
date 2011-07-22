class AddIndexUsernameToNonProfit < ActiveRecord::Migration
  def self.up
    add_index :non_profits,:username
  end

  def self.down
    remove_index :non_profits,:username
  end
end
