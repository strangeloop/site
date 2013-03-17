class RenameSlugColumns < ActiveRecord::Migration
  def up
    rename_column :attendees, :cached_slug, :slug
    rename_column :conference_sessions, :cached_slug, :slug
  end

  def down
    rename_column :conference_sessions, :slug, :cached_slug
    rename_column :attendees, :slug, :cached_slug
  end
end
