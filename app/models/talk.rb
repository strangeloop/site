class Talk < ActiveRecord::Base

  [:title, :abstract, :video_approval, :talk_type].each do |field|
    validates field, :presence => true
  end

  has_and_belongs_to_many :speakers

  accepts_nested_attributes_for :speakers

  def self.video_approvals
    ["Yes", "No", "Maybe"]
  end

  def self.talk_types
    ["Deep Dive", "Intro", "Survey", "Other"]
  end

  validates_inclusion_of :video_approval, :in => video_approvals
  validates_inclusion_of :talk_type, :in => talk_types

  validates_length_of :title, :maximum => 55
  validates_length_of :abstract, :maximum => 1200

  before_create AddConfYear

  acts_as_taggable_on :tags

  accepts_nested_attributes_for :tags
  
  def self.to_csv(talks)
    FasterCSV.generate({:force_quotes => true}) do |csv|
      csv << ["conf_year", "title", "talk_type", "abstract", "comments", 
        "prereqs", "av_requirement", "video_approval", "speakers", 
        "created_at", "updated_at"]
      talks.each do |t|
      	speakers = t.speakers.to_a
        csv << [t.conf_year, t.title, t.talk_type, t.abstract, t.comments, 
          t.prereqs, t.av_requirement, t.video_approval, speakers.join(","), 
          t.created_at, t.updated_at]
      end
    end
  end
  
end
