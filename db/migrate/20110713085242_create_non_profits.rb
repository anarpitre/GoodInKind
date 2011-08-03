class CreateNonProfits < ActiveRecord::Migration
  def self.up
    create_table :non_profits do |t|
      t.string  :name
      t.string  :contact_name
      t.string  :EIN
      t.string  :uuid
      t.string  :email
      t.string  :username
      t.string  :hashed_password
      t.string  :salt
      t.string  :mission_statement
      t.string  :website
      t.boolean :is_temp_pwd, :default =>true #
      t.boolean :is_verified, :default => false #
      t.boolean :is_active, :default => true  #
      t.string  :permalink
      t.string :phone_number
      t.text    :description
      t.integer :gateway_id
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      t.timestamps
    end
     
  end

  def self.down
    drop_table :non_profits
  end
end
