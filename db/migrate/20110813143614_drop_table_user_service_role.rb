class DropTableUserServiceRole < ActiveRecord::Migration
  def self.up
    drop_table :user_service_roles
  end
end
