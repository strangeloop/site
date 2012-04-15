class RemoveTrackFromConferenceSession < ActiveRecord::Migration
  def self.up
    ConferenceSession.all.each do |conf|
      talk = conf.talk
      talk.track = conf.track
      talk.save
    end

    remove_column :conference_sessions, :track_id
  end

  def self.down
    add_column :conference_sessions, :track_id, :integer

    Talk.all.each do |talk|
      conf = ConferenceSession.where(:talk_id => talk.id).first
      if talk.track
        conf.track = talk.track
        conf.save
      end
    end
  end
end
