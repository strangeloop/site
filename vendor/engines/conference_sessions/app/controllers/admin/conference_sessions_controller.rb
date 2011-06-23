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



module Admin
  class ConferenceSessionsController < Admin::BaseController
    include ImageUploadFix

    [:find_format_options, :find_session_times, :find_rooms, :find_tracks].each do |fltr|
      prepend_before_filter fltr, :only => [:new, :edit]
    end

    crudify :conference_session

    def index
      search_all_conference_sessions if searching?
      paginate_all_conference_sessions

      render :partial => 'conference_sessions' if request.xhr?
    end

    def new
      @conference_session = ConferenceSession.new(:talk => Talk.new(:speakers => [Speaker.new]))
    end

    #callback invoked by ImageUploadFix
    def image_in_params(params)
      params[:conference_session][:talk_attributes][:speakers_attributes]["0"]
    end

    def find_format_options
      @format_options = ConferenceSession::format_options
    end

    def find_session_times
      @session_times = SessionTime.current_year
    end

    def find_rooms
      @rooms = Room.current_year
    end

    def find_tracks
      @tracks = Track.current_year
    end

    def export
      respond_to do |format|
        format.csv { render :xml => ConferenceSession.to_csv(params[:year]) }
      end
    end
  end
end
