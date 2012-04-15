class AddTrackToTalk < ActiveRecord::Migration
  def self.up
    add_column :talks, :track_id, :integer
  end

  def self.down
    remove_column :talks, :track_id
  end
end
