class AddCachedSlugToConferenceSession < ActiveRecord::Migration
  def self.up
    add_column :conference_sessions, :cached_slug, :string
    add_index  :conference_sessions, :cached_slug, :unique => true
  end

  def self.down
    remove_column :conference_sessions, :cached_slug
  end
end
