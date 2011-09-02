class CreateCcTokens < ActiveRecord::Migration
  def self.up
    create_table :cc_tokens do |t|
      t.integer :user_id
      t.string :credit_card
      t.string :cardonfile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cc_tokens
  end
end
