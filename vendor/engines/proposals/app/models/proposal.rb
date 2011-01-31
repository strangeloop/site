class Proposal < ActiveRecord::Base

  acts_as_indexed :fields => [:status]
  
  validates_inclusion_of :status, :in => %w(submitted under\ review accepted rejected)
  
end
