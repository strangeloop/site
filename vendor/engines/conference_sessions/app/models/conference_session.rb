class ConferenceSession < ActiveRecord::Base
  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk

  #acts_as_indexed :fields => [:title]

  validates_inclusion_of :format, :in => %w(keynote workshop talk lightning undefined)
  validates_presence_of :talk

  has_friendly_id :title, :use_slug => true
  
  def format
    self[:format] || 'undefined'
  end

  def title
    talk.title
  end
end
