class AddIndexesToManyTables < ActiveRecord::Migration
  def self.up
    add_index :attendees, :cached_slug, :unique => true
    add_index :attendees, :first_name
    add_index :attendees, :last_name
    add_index :attendees, :user_id
    add_index :conference_sessions, :session_time_id
    add_index :rooms, :name
    add_index :session_times, :start_time
    add_index :speakers_talks, [:speaker_id, :talk_id], :unique => true
  end

  def self.down
    remove_index :speakers_talks, :column => [:speaker_id, :talk_id]
    remove_index :session_times, :start_time
    remove_index :conference_sessions, :session_time_id
    remove_index :rooms, :name
    remove_index :attendees, :user_id
    remove_index :attendees, :last_name
    remove_index :attendees, :first_name
    remove_index :attendees, :cached_slug
  end
end
