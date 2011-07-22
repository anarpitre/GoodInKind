class CreateNonProfits < ActiveRecord::Migration
  def self.up
    create_table :non_profits do |t|
      t.string  :non_profit_name
      t.string  :contact_name
      t.string  :EIN
      t.string  :uuid
      t.string  :email
      t.string  :username
      t.string  :password
      t.boolean :is_temporary
      t.boolean :is_verified
      t.string  :permalinks
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
