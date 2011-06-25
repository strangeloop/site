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
  cache_sweeper :clear_schedule_cache

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


  def index
  end

  def show
  end

  def schedule
  end
end
