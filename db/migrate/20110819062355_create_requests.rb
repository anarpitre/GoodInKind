class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.string :email
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
