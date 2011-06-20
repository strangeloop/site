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



class ConferenceSession < ActiveRecord::Base
  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk
  belongs_to :session_time
  belongs_to :room

  acts_as_indexed :fields => [:conf_year]
  accepts_nested_attributes_for :talk

  def self.format_options
    %w(keynote workshop talk lightning undefined strange\ passions panel miscellaneous)
  end

  validates_inclusion_of :format, :in => format_options
  validates_presence_of :talk

  before_create AddConfYear

  has_friendly_id :title, :use_slug => true

  scope :defined_format, where('format <> ?', 'undefined')
  scope :by_start_time_and_room, includes(:session_time, :room).order('session_times.start_time', 'rooms.position ASC')

  def format
    self[:format] || 'undefined'
  end

  def title
    talk.title
  end

  def day
    session_time.nil? ? 'Unscheduled' : session_time.start_time.strftime('%A, %B %d, %Y')
  end

  def start_time
    session_time.try(:start_time)
  end

  class <<self
    def all_years
      this_year = Time.now.year
      ((minimum('conf_year') || this_year)..this_year).to_a.reverse
    end

    def from_year(year = nil)
      where(:conf_year => year || maximum('conf_year'))
    end

    #returns ordered map of "defined" conference sessions, for
    #the current year, keyed by session day, then session_time (ascending)
    def by_session_time
      sessions = defined_format.from_year.by_start_time_and_room
      hash = ActiveSupport::OrderedHash.new{|h, k| h[k] = ConferenceSession::new_ordered_hash_of_arrays }
      sessions.each{|session| hash[session.day][session.session_time] << session }
      hash
    end

    def to_csv(year = nil)
      FasterCSV.generate({:force_quotes => true}) do |csv|
        csv << ["conf_year", "start_time", "position", 
          "title", "format", "talk_type", 
          "abstract", "comments", "prereqs", 
          "av_requirement", "video_approval", "speaker"]
        from_year(year).each do |c|
          speakers = c.talk.speakers.to_a
          csv << [c.conf_year, c.start_time, c.position, 
            c.title, c.format, c.talk.talk_type, 
            c.talk.abstract, c.talk.comments, c.talk.prereqs, 
            c.talk.av_requirement, c.talk.video_approval, speakers.join(";")]
        end
      end
    end
  end

  private
  class <<self
    def new_ordered_hash_of_arrays
      ActiveSupport::OrderedHash.new{|h, k| h[k] = []}
    end
  end
end
