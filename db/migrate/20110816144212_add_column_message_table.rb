class AddColumnMessageTable < ActiveRecord::Migration
 
  def self.up
    add_column :messages, :sender_id, :integer
    add_column :messages, :receiver_id, :integer
    add_column :messages, :is_replied, :boolean, :default => false
  end

  def self.down
    remove_column :messages, :sender_id
    remove_column :messages, :receiver_id
    remove_column :messages, :is_replied
  end

end
