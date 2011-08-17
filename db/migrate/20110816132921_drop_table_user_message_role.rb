class DropTableUserMessageRole < ActiveRecord::Migration
  def self.up
    drop_table :user_message_roles
  end
end
