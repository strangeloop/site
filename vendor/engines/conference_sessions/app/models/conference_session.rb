class ConferenceSession < ActiveRecord::Base
  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk

  acts_as_indexed :fields => [:conf_year]
  accepts_nested_attributes_for :talk

  def self.format_options
    %w(keynote workshop talk lightning undefined)
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
      (minimum('conf_year')..Time.now.year).to_a.reverse
    end

    def from_year(year = nil)
      where(:conf_year => year || Time.now.year)
    end
  end
end
