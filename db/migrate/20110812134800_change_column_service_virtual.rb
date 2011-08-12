class ChangeColumnServiceVirtual < ActiveRecord::Migration
  def self.up
   change_column :services, :is_virtual, :boolean, :default => false
  end

  def self.down
   remove_column :services, :is_virtual
  end
end
