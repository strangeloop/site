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



class Talk < ActiveRecord::Base

  attr_accessible :talk, :abstract, :video_approval, :talk_type, :speakers, :title, :duration
  
  [:title, :abstract, :video_approval, :talk_type].each do |field|
    validates field, :presence => true
  end

  has_and_belongs_to_many :speakers
  belongs_to :track

  accepts_nested_attributes_for :speakers

  def self.video_approvals
    ["Yes", "No", "Maybe"]
  end

  def self.talk_types
    ["Deep Dive", "Intro", "Survey", "Other"]
  end

  def self.talk_durations
    ["50 Minutes", "20 Minutes"]
  end

  def duration
    self[:duration] || Talk.talk_durations.first
  end

  def track_name
    track ? track.name : ""
  end

  validates_inclusion_of :video_approval, :in => video_approvals
  validates_inclusion_of :talk_type, :in => talk_types
  validates_inclusion_of :duration, :in => talk_durations, :allow_nil => true

  validates_length_of :title, :maximum => 55
  validates_length_of :abstract, :maximum => 2000

  acts_as_taggable_on :tags

  accepts_nested_attributes_for :tags

  def main_speaker
    speakers.first
  end
end
