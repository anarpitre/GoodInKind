class RemoveMissionStatementFromNonprofit < ActiveRecord::Migration
  def self.up
    remove_column :nonprofits, :mission_statement
  end

  def self.down
    add_column :nonprofits, :mission_statement, :string
  end
end
