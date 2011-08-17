class DropTableServiceNonprofits < ActiveRecord::Migration
  def self.up
    drop_table :service_nonprofits
  end

  def self.down
  end
end
