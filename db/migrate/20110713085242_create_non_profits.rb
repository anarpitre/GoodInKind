class CreateNonProfits < ActiveRecord::Migration
  def self.up
    create_table :non_profits do |t|
      t.string  :name
      t.string  :EIN
      t.text    :description
      t.integer :gateway_id
      t.string  :document1_file_name
      t.string  :document2_file_name
      t.string  :photo_file_name
      t.string  :document1_content_type
      t.string  :document2_content_type
      t.string  :photo_content_type
      t.integer :document1_file_size
      t.integer :document2_file_size
      t.integer :photo_file_size
      t.boolean :is_verified

      t.timestamps
    end
  end

  def self.down
    drop_table :non_profits
  end
end
