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



module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /the new talks page/
      new_talk_path

    when /the review proposals page/
      admin_proposals_path

    when /the default proposal review page/
      edit_admin_proposal_path Proposal.first

    when /the default conference session page/
      edit_admin_conference_session_path ConferenceSession.first

    when /the sessions page/
      conference_sessions_path

    when /the session details page for (.*)$/
      conference_session_path friendly_id($1)

    when /the conference sessions admin index page/
      admin_conference_sessions_path

    when /the sponsorship admin page/
      admin_sponsorships_path

    when /the room index page/
      admin_rooms_path

    when /the session times index page/
      admin_session_times_path

    when /the track index page/
      admin_tracks_path

    when /the edit profile page/
      edit_attendee_path

    when /the profile page for (.*)$/
      attendee_path friendly_id($1)

    when /my profile page/
      attendee_path friendly_id(Attendee.first.full_name)

    when /my activation page/
      activation_path(:token => Attendee.first.activation_token)

    when /my bad activation token page/
      activation_path(:token => "foo")

    when /the attendee login page/
      new_attendee_session_path

    when /the dashboard page/
      '/refinery'

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def friendly_id(glob)
    glob.downcase.gsub(' ', '-').gsub("\"", '')
  end
end

World(NavigationHelpers)
