class ConferenceSession < ActiveRecord::Base

  acts_as_indexed :fields => [:title]

  validates :title, :presence => true, :uniqueness => true
  
  belongs_to :slides, :class_name => 'Resource'
  belongs_to :talk
end
