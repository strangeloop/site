class RemoveDefaultConfYearColumnValue < ActiveRecord::Migration
  def self.up
    change_column :conference_sessions, :conf_year, :integer, :default => nil
  end

  def self.down
    change_column :conference_sessions, :conf_year, :integer, :default => Time.now.year
  end
end
