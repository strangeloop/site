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

  # Returns hash of comments and ratings (appeal dimension) that uses user
  # as the key. Each value is a hash with :comments and :rating as its key.
  # The :comments value is a list of comments from the user for this proposal
  # The :rating is a single rating
  def comments_and_appeal_ratings
    collector = Hash.new{|hash, key| hash[key] = {} }
    comments_ordered_by_submitted.each{|comment| 
      values_hash = collector[comment.user]
      (values_hash[:comments] ||= []) << comment
    }
    rates(:appeal).each{|rating| collector[rating.rater][:rating] = rating }
    collector
  end
  
  def self.to_csv(status)
    proposals = where(:status => status)
    FasterCSV.generate({:force_quotes => true}) do |csv|
      csv << [:status, :position, :created_at, 
        :updated_at, :title, :talk_type, 
        :abstract, :comments, :prereqs, 
        :av_requirement, :video_approval, :speakers]
      proposals.each do |p|
        speakers = p.talk.speakers.to_a
        csv << [p.status, p.position, p.created_at, 
          p.updated_at, p.talk.title, p.talk.talk_type, 
          p.talk.abstract, p.talk.comments, p.talk.prereqs, 
          p.talk.av_requirement, p.talk.video_approval, speakers.join(",")]
      end
    end
  end
end
