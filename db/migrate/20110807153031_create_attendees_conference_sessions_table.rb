class CreateAttendeesConferenceSessionsTable < ActiveRecord::Migration
  def self.up
    create_table :attendees_conference_sessions, :id => false do |t|
      t.references :attendee, :null => false
      t.references :conference_session, :null => false
    end

    add_index :attendees_conference_sessions, [:attendee_id, :conference_session_id], :unique => true, :name => 'attendees_to_conference_sessions'
  end

  def self.down
    drop_table :attendees_conference_sessions
  end
end
