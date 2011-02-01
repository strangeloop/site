class Proposal < ActiveRecord::Base
  belongs_to :talk

  acts_as_indexed :fields => [:status]
  
  validates_inclusion_of :status, :in => %w(submitted under\ review accepted rejected)
  validates_presence_of :talk
end
