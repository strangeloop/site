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



module ApplicationHelper

  def link_tree(pages = [])
    pages.inject([]) do |arr, page|
      size = page.children.size + 1
      if arr.empty? || arr.last[:size] + size > tree_row_height
        holder = {}
        holder[:size] = size
        holder[:pages] = [page]
        arr << holder
      else
        last = arr.last
        last[:size] += size
        last[:pages] << page
      end
      arr
    end.map{|groups| groups[:pages]}
  end

  def speaker_for(talk)
    speaker = talk.speakers.first
    "#{speaker.first_name} #{speaker.last_name}"
  end

  def twitter_link(twitter_id = '', tag_type = :strong)
    custom_link twitter_id, "@#{twitter_id}", 'twitter.com', :tag_type => tag_type
  end

  def github_link(github_id = '')
    custom_link github_id, github_id, 'github.com'
  end

  def work_for_pie_link(work_for_pie_id = '')
    custom_link work_for_pie_id, work_for_pie_id, 'workforpie.com', :protocol => 'http'
  end

  def schedule_key
    current_user.nil? ? 'schedule' : 'auth-schedule'
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

  def time_period_for(session_time)
    session_time.nil? ? "00:00 AM - 00:00 PM" : session_time.time_period
  end

  def show_schedule_selection?(key = 'schedule')
    key == 'auth-schedule'
  end

  def track_name(session)
    session.track.nil? ? '' : session.track.name
  end

  def room_for(session)
    session.room.nil? ? "Room ???" : session.room
  end

  def is_technical_track?(session)
    session.track && session.format && session.format != 'miscellaneous'
  end

  def track_color(session)
    session.track.nil? ? '000' : session.track.color
  end

  # expects an Image object as the first param and a display size (:small or :medium)
  # returns a "default" image tag if no/nil Image is supplied
  def image_tag_for(image = nil, size = :medium)
    image.nil? ? image_tag(default_image[size]) : image_fu(image, size)
  end

  private
  def default_image
    {:medium => 'attendees.jpeg', :small => 'attendees-small.jpeg'}
  end

  def tree_row_height
    7
  end

  def custom_link(id, display_content, url, options = {})
    opts = {:tag_type => :strong, :protocol => 'https'}.merge(options)
    link_to(content_tag(opts[:tag_type], display_content), "#{opts[:protocol]}://#{url}/#{id}") unless id.blank?
  end
end
