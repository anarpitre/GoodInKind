class AddColumnQualified < ActiveRecord::Migration
  def self.up
    add_column :services, :qualification, :text
  end

  def self.down
    remove_column :services, :qualification
  end
end
