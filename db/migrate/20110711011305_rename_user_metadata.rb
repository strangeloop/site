class RenameUserMetadata < ActiveRecord::Migration
  def self.up
    rename_table :user_metadata, :attendees
  end

  def self.down
    rename_table :attendees, :user_metadata
  end
end
