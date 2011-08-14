class RemoveIsTempPwdFromNonprofits < ActiveRecord::Migration
  def self.up
    remove_column :nonprofits, :is_temp_pwd
  end

  def self.down
    add_column :nonprofits, :is_temp_pwd, :boolean
  end
end
