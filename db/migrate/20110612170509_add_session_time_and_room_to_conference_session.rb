class AddSessionTimeAndRoomToConferenceSession < ActiveRecord::Migration
  def self.up
    add_column :conference_sessions, :session_time_id, :integer
    add_column :conference_sessions, :room_id, :integer
    remove_column :conference_sessions, :start_time
  end

  def self.down
    add_column :conference_sessions, :start_time, :datetime
    remove_column :conference_sessions, :session_time_id
    remove_column :conference_sessions, :room_id
  end
end
