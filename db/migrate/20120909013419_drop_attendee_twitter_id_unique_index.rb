class DropAttendeeTwitterIdUniqueIndex < ActiveRecord::Migration
  def self.up
    remove_index :attendees, :twitter_id
  end

  def self.down
    add_index :attendees, :twitter_id, :unique => true
  end
end
