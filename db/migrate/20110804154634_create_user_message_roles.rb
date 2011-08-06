class CreateUserMessageRoles < ActiveRecord::Migration
  def self.up
    create_table :user_message_roles do |t|
      t.integer :user_id
      t.integer :message_id
      t.string :role
      t.timestamps
    end
  end

  def self.down
    drop_table :user_message_roles
  end
end
