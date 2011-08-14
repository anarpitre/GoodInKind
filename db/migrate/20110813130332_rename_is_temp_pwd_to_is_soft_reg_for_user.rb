class RenameIsTempPwdToIsSoftRegForUser < ActiveRecord::Migration
  def self.up
    change_column :users, :is_temp_pwd, :boolean, :default => false
    rename_column :users, :is_temp_pwd, :is_soft_reg
  end

  def self.down
    rename_column :users, :is_soft_reg, :is_temp_pwd
  end
end
