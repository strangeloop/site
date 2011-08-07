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

  has_and_belongs_to_many :conference_sessions
  belongs_to :user
  [:first_name, :last_name, :email, :reg_id].each do |field|
    validates field, :presence => true
  end

  before_create {|um| um.acct_activation_token= UUIDTools::UUID.random_create.to_s}
  before_create AddConfYear

  has_friendly_id :full_name, :use_slug => true

  scope :current_year, lambda { where('conf_year' => maximum('conf_year')).order('last_name ASC', 'first_name ASC') }

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
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
      nil
    end
  end

  def activation_token
    Base64.encode64(Crypto.encrypt(@@activation_key, [email,acct_activation_token,token_created_at].join("|")))
  end

  def self.decrypt_token (cipher_text)
    Crypto.decrypt(@@activation_key, Base64.decode64(cipher_text)).split("|")
  end

  def self.check_token (cipher_text)
    token = decrypt_token(cipher_text)
    date = DateTime.parse(token[2])
    attendee =  Attendee.where("acct_activation_token = ?", token[1]).first
    attendee && attendee.token_created_at == date && attendee.email == token[0]
  end
end
