class Talk < ActiveRecord::Base

  [:title, :abstract].each do |field|
    validates field, :presence => true
  end

  has_and_belongs_to_many :speakers

  accepts_nested_attributes_for :speakers

  def self.video_approvals
    ["Yes", "No", "Maybe"]
  end

  def self.talk_types
    ["Deep Dive", "Intro", "Survey"]
  end

  def self.tracks
    ["Languages", "JVM", "NoSQL"]
  end

  def self.talk_lengths
    ["5 Minutes", "50 Minutes", "80 Minutes"]
  end

  validates_inclusion_of :video_approval, :in => video_approvals
  validates_inclusion_of :talk_type, :in => talk_types
  validates_inclusion_of :track, :in => tracks
  validates_inclusion_of :talk_length, :in => talk_lengths

  before_create AddConfYear

  acts_as_taggable_on :tags
  
end
