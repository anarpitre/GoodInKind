class AddFieldsToNonprofits < ActiveRecord::Migration
  def self.up
    add_column :nonprofits, :show_contact_details, :boolean, :default => true
    remove_column :nonprofits, :category_id
  end

  def self.down
    remove_column :nonprofits, :show_contact_details
    add_column :nonprofits, :category_id, :integer
  end
end
