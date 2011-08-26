class AddColumnPasswordResetToken < ActiveRecord::Migration
  def self.up
    add_column :nonprofits, :reset_password_token, :string
  end

  def self.down
    remove_column :nonprofits, :reset_password_token
  end
end
