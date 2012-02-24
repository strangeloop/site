#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



class Proposal < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :talk
  ajaxful_rateable :stars => 5, :dimensions => [:appeal]

  acts_as_indexed :fields => [:status]

  acts_as_commentable

  validates_inclusion_of :status, :in => %w(submitted under\ review accepted rejected)
  validates_presence_of :talk

  accepts_nested_attributes_for :talk

  scope :pending, lambda {
    where(:status => ['submitted', 'under review'])
  }

  scope :current, lambda {
    where('created_at > ?', DateTime.parse("Jan 1, #{Time.now.year}"))
  }

  scope :talk, lambda { where(:format => 'talk') }
  scope :workshop, lambda { where(:format => 'workshop') }

  def comments_by_user(user)
    comments_ordered_by_submitted.select{|item| item.user_id == user.id}
  end

  def accepted?
    self.status == 'accepted'
  end

  def rejected?
    self.status == 'rejected'
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

  memoize :comments_and_appeal_ratings

  class << self

    def pending_count
      current.pending.count
    end

    def all_to_csv
      proposals = Proposal.current.order("status ASC")
      reviewers = sorted_reviewers(proposals)
      FasterCSV.generate({:force_quotes => true}) do |csv|
        csv << pending_csv_header_values(reviewers)
        proposals.each do |proposal|
          csv << pending_csv_data_values(proposal, reviewers)
        end
      end
    end

    # Returns a sorted array of unique reviewer usernames for the current
    # pending proposals.
    def sorted_reviewers(proposals)
      reviewers = []
      proposals.each do|proposal|
        hash = proposal.comments_and_appeal_ratings
        hash.each_key do |user|
          reviewer_name = user.username
          reviewers << reviewer_name unless reviewers.include?(reviewer_name)
        end
      end
      reviewers.sort
    end

    def user_rating(username, user_ratings)
      user_ratings.each do |user, value|
        return value[:rating].stars.to_s if user.username == username && value[:rating]
      end
      ""
    end

    # Returns an array of header values to be used in a pending CSV
    # header row.
    def pending_csv_header_values(reviewers)
      ["title", "status", "speaker", "sp1 first name", "sp1 last name", "sp1 company", "sp1 email", "sp1 twitter id"] + reviewers
    end

    # Returns an array of values from a proposal to be used in a pending
    # CSV data row.
    def pending_csv_data_values(proposal, reviewers)
      speaker1 = proposal.talk.speakers[0]
      data = [proposal.talk.title, proposal.status, proposal.talk.speakers.to_a.join(";"),
        speaker1.first_name, speaker1.last_name,
        speaker1.company, speaker1.email, speaker1.twitter_id]
      user_ratings = proposal.comments_and_appeal_ratings
      reviewers.inject(data){|d, reviewer| d << user_rating(reviewer, user_ratings)}
    end
  end
end
