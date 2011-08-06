class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :service_id
      t.integer :group_number
      t.integer :user_id
      t.text :review
      t.boolean :is_positive, :default => true
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
