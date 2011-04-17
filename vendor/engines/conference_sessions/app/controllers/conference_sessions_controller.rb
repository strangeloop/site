class ConferenceSessionsController < ApplicationController
  expose(:conference_sessions) { ConferenceSession.order(:position) }
  expose(:sessions_by_format) do
    conference_sessions.inject(Hash.new{|h, k| h[k] = []}) {|sessions, conf_session| 
      sessions[conf_session.format] << conf_session
      sessions
    }
  end
  expose(:conference_session)
  expose(:talk) { conference_session.talk }
  expose(:speaker) { talk.speakers.first }


  def index
  end

  def show
  end
end
