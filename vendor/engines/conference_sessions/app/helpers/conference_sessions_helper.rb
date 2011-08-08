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



module ConferenceSessionsHelper
  def time_period_for(session_time)
    session_time.nil? ? "00:00 AM - 00:00 PM" : session_time.time_period
  end

  def room_for(session)
    session.room.nil? ? "Room ???" : session.room
  end

  def is_technical_track?(session)
    session.track && session.format && session.format != 'miscellaneous'
  end

  def track_name(session)
    session.track.nil? ? '' : session.track.name
  end

  def track_color(session)
    session.track.nil? ? '000' : session.track.color
  end

  def time_column_height(session_count)
    session_count * (case session_count
                      when 1
                        300
                      when 2
                        320
                      when 3
                        350
                      when 4..5
                        375
                      else
                        385
                    end)
  end

  def schedule_key
    current_user.nil? ? 'schedule' : 'auth-schedule'
  end

  def show_schedule_selection?(key = 'schedule')
    key == 'auth-schedule'
  end
end
