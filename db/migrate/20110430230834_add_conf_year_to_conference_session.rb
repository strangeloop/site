class AddConfYearToConferenceSession < ActiveRecord::Migration
  def self.up
    add_column :conference_sessions, :conf_year, :integer, :default => Time.now.year
    remove_column :talks, :conf_year
  end

  def self.down
    add_column :talks, :conf_year, :integer
    remove_column :conference_sessions, :conf_year
  end
end
