class AddColumnHideEmailGender < ActiveRecord::Migration
  def self.up
    add_column :profiles, :hide_gender, :boolean, :default => false
    add_column :profiles, :hide_email, :boolean, :default => false
  end

  def self.down
    remove_column :profiles, :hide_gender
    remove_column :profiles, :hide_email
  end
end
