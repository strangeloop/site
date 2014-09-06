#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



class ConferenceSessionsController < ApplicationController
  before_filter :authenticate_attendee_cred!, :only => :toggle_session

  expose(:attendee) do
    Attendee.find_by_attendee_cred_id(current_attendee_cred.id) if current_attendee_cred
  end

  expose(:attendee_session_ids) do
    ids = [] unless attendee
    ids ||= attendee.conference_session_ids
  end

  expose(:year) { params[:year] || Time.now.year }
  expose(:sessions_from_year) { ConferenceSession::from_year(year) }
  expose(:sessions_by_format) do
    sessions_from_year.inject(Hash.new{|h, k| h[k] = []}) {|sessions, conf_session|
      sessions[conf_session.format] << conf_session
      sessions
    }
  end
  expose(:sessions_for_schedule) { ConferenceSession::by_session_time }
  expose(:conference_session)
  expose(:talk) { conference_session.talk }
  expose(:speaker) { talk.speakers.first }

  expose(:fpw_schedule) { ConferenceSession::by_short_session_time_and_location_for_formats('fpw') }
  expose(:workshop_schedule) { ConferenceSession::by_session_time_for_formats('workshop', 'free workshop') }
  expose(:main_schedule) { ConferenceSession::by_short_session_time_and_location_for_formats('keynote', 'talk', 'miscellaneous', 'unsession') }

  def index
  end

  def index_workshop
  end

  def show
  end

  def schedule
  end

  def toggle_session
    will_attend = attendee.toggle_session(params[:sessionid].to_i)
    render :json => {:willAttend => will_attend}
  end
end
