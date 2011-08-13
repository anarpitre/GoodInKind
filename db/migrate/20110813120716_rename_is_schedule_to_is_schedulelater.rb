class RenameIsScheduleToIsSchedulelater < ActiveRecord::Migration
  def self.up
    rename_column :services, :is_scheduled, :is_schedulelater
  end

  def self.down
    rename_column :services, :is_schedulelater, :is_scheduled
  end
end
