class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|

      t.integer :user_id
      t.string  :first_name
      t.string  :last_name
      t.integer :age, :default => 0
      t.string  :gender
      t.string  :website
      t.text    :about_me
      t.string  :avatar_file_name
      t.string  :avatar_content_type
      t.integer :avatar_file_size
      t.boolean :is_verified
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
