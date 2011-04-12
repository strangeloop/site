class AddTypeToConferenceSession < ActiveRecord::Migration
  def self.up
    add_column :conference_sessions, :format, :string
    remove_column :conference_sessions, :title
    remove_column :talks, :talk_length
  end

  def self.down
    add_column :talks, :talk_length, :string
    add_column :conference_sessions, :title, :string
    remove_column :conference_sessions, :format
  end
end
