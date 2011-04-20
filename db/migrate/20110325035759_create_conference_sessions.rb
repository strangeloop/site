class CreateConferenceSessions < ActiveRecord::Migration

  def self.up
    create_table :conference_sessions do |t|
      t.datetime :start_time
      t.references :talk
      t.string :format
      t.integer :slides_id
      t.integer :position

      t.timestamps
    end

    add_index :conference_sessions, :id

    load(Rails.root.join('db', 'seeds', 'conference_sessions.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "conference_sessions"})

    Page.delete_all({:link_url => "/conference_sessions"})

    drop_table :conference_sessions
  end

end
