class SlurpTracksToTalks < ActiveRecord::Migration
  def self.up
    remove_column :talks, :track_id
    drop_table :tracks
    add_column :talks, :track, :string
  end

  def self.down
    remove_column :talks, :track

    create_table "tracks", :force => true do |t|
      t.string   "abbrev"
      t.string   "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_column :talks, :references, :track_id
  end
end
