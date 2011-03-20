class RemoveTrackFromTalk < ActiveRecord::Migration
  def self.up
    remove_column :talks, :track
  end

  def self.down
    add_column :talks, :track, :string
  end
end
