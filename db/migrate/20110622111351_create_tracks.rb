class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :name
      t.string :color
      t.integer :conf_year

      t.timestamps
    end

    add_column :conference_sessions, :track_id, :integer
  end

  def self.down
    remove_column :conference_sessions, :track_id
    drop_table :tracks
  end
end
