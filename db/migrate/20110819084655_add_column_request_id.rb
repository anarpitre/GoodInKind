class AddColumnRequestId < ActiveRecord::Migration
  def self.up
    add_column :services, :request_id, :integer, :deault => 0
  end

  def self.down
    remove_column :services, :request_id
  end
end
