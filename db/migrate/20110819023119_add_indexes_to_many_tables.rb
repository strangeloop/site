class AddIndexesToManyTables < ActiveRecord::Migration
  def self.up
    add_index :attendees, :cached_slug, :unique => true
    add_index :attendees, :first_name
    add_index :attendees, :last_name
    add_index :attendees, :twitter_id, :unique => true
    add_index :attendees, :acct_activation_token, :unique => true
    add_index :attendees, :email, :unique => true
    add_index :conference_sessions, :session_time_id
    add_index :rooms, :name
    add_index :services, [:provider, :uemail], :unique => true
    add_index :session_times, :start_time
    add_index :speakers_talks, [:speaker_id, :talk_id], :unique => true
  end

  def self.down
    remove_index :speakers_talks, :column => [:speaker_id, :talk_id]
    remove_index :session_times, :start_time
    remove_index :services, [:provider, :uemail]
    remove_index :conference_sessions, :session_time_id
    remove_index :rooms, :name
    remove_index :attendees, :email
    remove_index :attendees, :twitter_id
    remove_index :attendees, :last_name
    remove_index :attendees, :first_name
    remove_index :attendees, :cached_slug
    remove_index :attendees, :acct_activation_token
  end
end
