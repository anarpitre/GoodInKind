class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :booking_id
      t.string :FG_trnx_id
      t.float :total_amount
      t.boolean :is_success
      t.text :failed_reason

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
