class ConferenceSessionsController < ApplicationController
  expose(:year) { params[:year] || Time.now.year }
  expose(:sessions_from_year) { ConferenceSession::from_year(year) }
  expose(:sessions_by_format) do
    sessions_from_year.inject(Hash.new{|h, k| h[k] = []}) {|sessions, conf_session| 
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
