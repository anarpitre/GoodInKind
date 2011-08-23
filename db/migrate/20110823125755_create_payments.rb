class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :seats
      t.string :extra
      t.integer :service_id
      t.integer :user_id
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
