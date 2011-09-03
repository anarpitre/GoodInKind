class ChangeEsitmatedDurationInService < ActiveRecord::Migration
  def self.up
    change_column :services, :estimated_duration, :float
  end

  def self.down
    change_column :services, :estimated_duration, :integer
  end
end
