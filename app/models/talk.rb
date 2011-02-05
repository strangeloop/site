class Talk < ActiveRecord::Base

  [:title, :abstract].each do |field|
    validates field, :presence => true
  end

  belongs_to :track
  belongs_to :talk_length

  has_and_belongs_to_many :speakers

  accepts_nested_attributes_for :speakers

  def self.video_approvals
    ["Yes", "No", "Maybe"]
  end

  def self.talk_types
    ["Deep Dive", "Intro", "Survey"]
  end

  validates_inclusion_of :video_approval, :in =>     ["Yes", "No", "Maybe"]
  validates_inclusion_of :talk_type, :in =>     ["Deep Dive", "Intro", "Survey"]

  before_create AddConfYear
  
end
