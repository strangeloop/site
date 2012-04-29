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

class Attendee < ActiveRecord::Base
  include Gravtastic

  acts_as_indexed :fields => [:conf_year]
  gravtastic

  @@activation_key = YAML::load_file('config/activation.yml')["activation_key"]

  attr_protected :reg_id, :attendee_cred_id, :conf_year

  has_and_belongs_to_many :conference_sessions,
                          :uniq => true

  belongs_to :attendee_cred
  [:first_name, :last_name, :email, :reg_id].each do |field|
    validates field, :presence => true
  end

  [:email, :twitter_id].each do |field|
    validates field, :uniqueness => true, :allow_nil => (field != :email)
  end

  before_create AddConfYear

  has_friendly_id :full_name, :use_slug => true

  scope :current_year, lambda { where('conf_year' => maximum('conf_year')).order('last_name ASC', 'first_name ASC') }

  def session_calendar
    RiCal.Calendar do |cal|
      conference_sessions.each do |session|
        cal.event do |e|
          e.summary     = session.title
          e.description = session.description
          e.dtstart     = session.start_time
          e.dtend       = session.end_time
          e.location    = session.location
          e.url         = session.url
        end
      end
    end
  end

  def twitter_id=(name)
    self[:twitter_id] = name.try(:gsub, '@', '')
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def remove_newlines(s)
    s.gsub(/\n/,'')
  end

  def sorted_interested_sessions
    conference_sessions.by_session_time
  end

  #returns false if the supplied id was removed from this attendees sessions list
  #returns true if the supplied id was added to this attendees sessions list
  #returns nil if an invalid session_id was supplied
  def toggle_session(session_id)
    if conference_session_ids.include? session_id
      conference_sessions.delete ConferenceSession.find(session_id)
      return false
    end
    begin
      conference_sessions << ConferenceSession.find(session_id)
      true
    rescue ActiveRecord::RecordNotFound
    end
  end

  def self.existing_attendee?(reg_id)
    Attendee.where("reg_id = ?", reg_id).first
  end

  def register_attendee

    db_attendee  = Attendee.existing_attendee?(reg_id)
    if !db_attendee
      build_attendee_cred({:email => email,
                            :password => ActiveSupport::SecureRandom.hex(10)})
      save!
      self
    else
      db_attendee
    end
  end
end
