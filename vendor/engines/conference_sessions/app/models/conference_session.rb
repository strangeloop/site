class ConferenceSession < ActiveRecord::Base
  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk

  acts_as_indexed :fields => [:conf_year]
  accepts_nested_attributes_for :talk

  def self.format_options
    %w(keynote workshop talk lightning undefined strange\ passions panel)
  end

  validates_inclusion_of :format, :in => format_options
  validates_presence_of :talk

  before_create AddConfYear

  has_friendly_id :title, :use_slug => true

  def format
    self[:format] || 'undefined'
  end

  def title
    talk.title
  end

  class <<self
    def all_years
      this_year = Time.now.year
      ((minimum('conf_year') || this_year)..this_year).to_a.reverse
    end

    def from_year(year = nil)
      where(:conf_year => year || Time.now.year)
    end
    
    def to_csv(year = nil)
      conferenceSessions = ConferenceSession.from_year(year)
      FasterCSV.generate({:force_quotes => true}) do |csv|
        csv << [:conf_year, :start_time, :position, 
          :title, :format, :talk_type, 
          :abstract, :comments, :prereqs, 
          :av_requirement, :video_approval, :speakers]
        conferenceSessions.each do |c|
          speakers = c.talk.speakers.to_a
          csv << [c.conf_year, c.start_time, c.position, 
            c.title, c.format, c.talk.talk_type, 
            c.talk.abstract, c.talk.comments, c.talk.prereqs, 
            c.talk.av_requirement, c.talk.video_approval, speakers.join(",")]
        end
      end
    end
  end
  
end
