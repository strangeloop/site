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

require 'session_formats'

class ConferenceSession < ActiveRecord::Base
  extend FriendlyId
  include Rails.application.routes.url_helpers
  include SessionFormats
  default_url_options[:host] = 'thestrangeloop.com'

  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk
  belongs_to :session_time
  belongs_to :room

  acts_as_indexed :fields => [:conf_year]
  accepts_nested_attributes_for :talk

  validates_inclusion_of :format, :in => format_options
  validates_presence_of :talk

  before_create AddConfYear

  friendly_id :title, :use => :slugged

  scope :defined_format, where('format <> ?', 'undefined')
  scope :for_formats, lambda{ |formats| where(:format => formats) }
  scope :by_start_time_and_room, includes(:session_time, :room).order('session_times.start_time', 'rooms.position ASC')

  scope :rooms_by_day_and_formats, lambda {|day, formats| includes(:session_time, :room).where('session_times.start_time >= ? and session_times.start_time < ?', day.strftime('%Y-%m-%d'), day.strftime('%Y-%m-%d').to_time + 1.day).where(:format => formats).order('rooms.position ASC') }

  [:title, :track, :track=].each {|field| delegate field, :to => :talk}

  def format
    self[:format] || 'undefined'
  end

  def description
    talk.abstract
  end

  def day
    session_time.nil? ? 'Unscheduled' : session_time.start_time.strftime('%A, %B %d, %Y')
  end

  def start_time
    session_time.try(:start_time)
  end

  def end_time
    session_time.try(:end_time)
  end

  def location
    room.try(:name)
  end

  def url
    conference_session_url(self)
  end

  def self.all_years
    this_year = Time.now.year
    ((minimum('conf_year') || this_year)..this_year).to_a.reverse
  end

  def self.from_year(year = nil)
    where(:conf_year => year || maximum('conf_year'))
  end

  #returns ordered map of "defined" conference sessions, for
  #the current year, keyed by session day, then session_time (ascending)
  def self.by_session_time
    sessions = defined_format.from_year.by_start_time_and_room
    hash = ActiveSupport::OrderedHash.new{|h, k| h[k] = ConferenceSession::new_ordered_hash_of_arrays }
    sessions.each{|session| hash[session.day][session.session_time] << session }
    hash
  end

  def self.by_session_time_for_formats(*formats)
    sessions = for_formats(formats).from_year(Time.now.year).by_start_time_and_room
    hash = ActiveSupport::OrderedHash.new{|h, k| h[k] = ConferenceSession::new_ordered_hash_of_arrays }
    sessions.each{|session| hash[session.day][session.session_time] << session }
    hash
  end

  def self.by_session_time_and_location_for_formats(*formats)
    sessions = for_formats(formats).from_year(Time.now.year).by_start_time_and_room
    hash = ActiveSupport::OrderedHash.new{|h, k| h[k] = ConferenceSession::new_ordered_hash_of_arrays_of_arrays }
    sessions.each{|session| hash[session.day][session.session_time.start_time.hour][session.location] << session }
    hash
  end

  def self.by_short_session_time_and_location_for_formats(*formats)
    sessions = for_formats(formats).from_year(Time.now.year).by_start_time_and_room
    hash = ActiveSupport::OrderedHash.new{|h, k| h[k] = ConferenceSession::new_ordered_hash_of_arrays_of_arrays }
    sessions.each{|session| hash[session.day][session.session_time.start_time][session.location] << session }
    hash
  end

  def self.to_csv(year = nil)
    CSV.generate({:force_quotes => true}) do |csv|
      csv << ["conf_year", "start_time", "end_time", "location", "position",
        "title", "format", "talk_type", "track", "abstract", "comments", "prereqs",
        "av_requirement", "video_approval", "speaker", "speaker_bio", "twitter_id", "company"]
      from_year(year).each do |c|
        speakers = c.talk.speakers.to_a
        speaker_bios = c.talk.speakers.collect { |s| s.bio }
        speaker_ids = c.talk.speakers.collect { |s| s.twitter_id }
        speaker_companies = c.talk.speakers.collect { |s| s.company }
        csv << [c.conf_year, c.start_time, c.end_time, c.location, c.position,
          c.title, c.format, c.talk.talk_type, c.talk.track_name,
          c.talk.abstract, c.talk.comments, c.talk.prereqs,
          c.talk.av_requirement, c.talk.video_approval, speakers.join(";"),
          speaker_bios.join(";"), speaker_ids.join(";"), speaker_companies.join(";")]
      end
    end
  end

  private
  class <<self
    def new_ordered_hash_of_arrays
      ActiveSupport::OrderedHash.new{|h, k| h[k] = [] }
    end

    def new_ordered_hash_of_arrays_of_arrays
      ActiveSupport::OrderedHash.new{|h, k| h[k] = ActiveSupport::OrderedHash.new{|h, k| h[k] = []} }
    end
  end
end
