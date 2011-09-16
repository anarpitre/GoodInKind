class AddColumnHideEmailFromNp < ActiveRecord::Migration
  def self.up
    add_column :profiles, :show_email_to_nonprofit, :boolean, :default => true
  end

  def self.down
    remove_column :profiles, :show_email_to_nonprofit
  end
end
