class CreateUserServiceRoles < ActiveRecord::Migration
  def self.up
    create_table :user_service_roles do |t|
      t.integer :user_id
      t.integer :service_id
      t.string :role
      t.timestamps
    end
  end

  def self.down
    drop_table :user_service_roles
  end
end
