class AddIsTempPwdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_temp_pwd, :boolean, :default => true
  end

  def self.down
    remove_column :users, :is_temp_pwd
  end
end
