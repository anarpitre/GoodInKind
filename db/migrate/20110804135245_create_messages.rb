class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :title
      t.text :message
      t.boolean :is_read, :default => false
      t.integer :parent_message_id, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
