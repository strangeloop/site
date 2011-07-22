class AddFieldsToAttendees < ActiveRecord::Migration
  def self.up
    add_column :attendees, :conf_year, :integer
    add_column :attendees, :github_id, :string
    add_column :attendees, :cached_slug, :string
    add_column :attendees, :company_url, :string
  end

  def self.down
    remove_column :attendees, :company_url
    remove_column :attendees, :cached_slug
    remove_column :attendees, :github_id
    remove_column :attendees, :conf_year
  end
end
