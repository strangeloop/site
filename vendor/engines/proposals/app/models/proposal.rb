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
  
  def self.pending_to_csv()
    proposals = pending
    reviewers = sorted_reviewers(pending)
    FasterCSV.generate({:force_quotes => true}) do |csv|
      csv << pending_csv_header_values(reviewers)
      proposals.each do |proposal|
        csv << pending_csv_data_values(proposal, reviewers)
      end
    end
  end
  
  # Returns a sorted array of unique reviewer usernames for the current 
  # pending proposals.
  def self.sorted_reviewers(proposals)
    reviewers = Array.new
  	proposals.each { |proposal|
  	  hash = proposal.comments_and_appeal_ratings
  	  hash.each { |user, value|
  	    reviewer_name = user.username
  	    if !reviewers.include?(reviewer_name)
  	      reviewers << reviewer_name
  	    end
  	  }
  	}
  	reviewers.sort
  end
  
  def self.user_rating(username, user_ratings)
    rating = ""
    user_ratings.each { |user, value|
    	if user.username == username
    	  rating = value[:rating].stars.to_s
    	  break
    	end
    }
    rating
  end
  
  # Returns an array of header values to be used in a pending CSV 
  # header row.
  def self.pending_csv_header_values(reviewers)
    header = ["title", "speaker"]
    reviewers.each { |reviewer| header << reviewer }
    header
  end
  
  # Returns an array of values from a proposal to be used in a pending
  # CSV data row.
  def self.pending_csv_data_values(proposal, reviewers)
  	data = [proposal.talk.title, proposal.talk.speakers.to_a.join(";")]
  	user_ratings = proposal.comments_and_appeal_ratings
  	reviewers.each { |reviewer|
  	  rating = user_rating(reviewer, user_ratings)
  	  data << rating
  	}
  	data
  end
end
