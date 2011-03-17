class Proposal < ActiveRecord::Base
  belongs_to :talk
  ajaxful_rateable :stars => 5, :dimensions => [:appeal]

  acts_as_indexed :fields => [:status]

  acts_as_commentable
  
  validates_inclusion_of :status, :in => %w(submitted under\ review accepted rejected)
  validates_presence_of :talk

  scope :pending, lambda {
    where(:status => ['submitted', 'under review'])
  }

  def comments_by_user(user)
    comments_ordered_by_submitted.select{|item| item.user_id == user.id}
  end

  def self.pending_count
    self.pending.count
  end
end
