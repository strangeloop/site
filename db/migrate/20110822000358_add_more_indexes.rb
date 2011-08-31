class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :conference_sessions, :room_id
    add_index :conference_sessions, :slides_id
    add_index :conference_sessions, :talk_id
    add_index :conference_sessions, :track_id
    add_index :news_items, :image_id
    add_index :proposals, :talk_id
    add_index :speakers, :image_id
    add_index :sponsors, :image_id
    add_index :sponsorships, :contact_id
    add_index :sponsorships, :sponsor_id
    add_index :sponsorships, :sponsorship_level_id
  end

  def self.down
    remove_index :sponsorships, :sponsorship_level_id
    remove_index :sponsorships, :sponsor_id
    remove_index :sponsorships, :contact_id
    remove_index :sponsors, :image_id
    remove_index :speakers, :image_id
    remove_index :proposals, :talk_id
    remove_index :news_items, :image_id
    remove_index :conference_sessions, :track_id
    remove_index :conference_sessions, :talk_id
    remove_index :conference_sessions, :slides_id
    remove_index :conference_sessions, :room_id
  end
end
