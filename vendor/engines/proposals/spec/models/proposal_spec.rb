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



require 'spec_helper'

describe Proposal do

  let(:reviewer) {Factory(:reviewer)}
  let(:user){Factory(:user)}
  let(:admin){Factory(:admin)}
  let(:alternate_reviewer) {Factory(:alternate_reviewer)}
  let(:alternate_reviewer2) {Factory(:alternate_reviewer2)}
  let(:alternate_reviewer3) {Factory(:alternate_reviewer3)}

  def valid_attributes(options = {})
    { :id => 1, :status => 'submitted' }.merge(options)
  end

  context "validations" do

    it "rejects empty status" do
      Proposal.new(valid_attributes(:status => "")).should_not be_valid
    end

    it "rejects invalid status" do
      Proposal.new(valid_attributes(:status => 'heynow')).should_not be_valid
    end

    it "rejects when there is no Talk" do
      Proposal.new(valid_attributes).should_not be_valid
    end

    it "requires valid attributes and a related Talk" do
      p = Proposal.new(valid_attributes)
      p.talk = Talk.new(:title => 'Writing a conf site', :abstract => 'Moar codez',
                        :video_approval => 'Yes', :talk_type => 'Intro', :duration => '50 Minutes')
      p.should be_valid
    end
  end

  it "shows no pending proposals when none exist" do
    Proposal.pending_count.should == 0
  end

  it "shows 1 pending count when one submitted proposal exists" do
    Factory(:proposal)
    Proposal.pending_count.should == 1
  end

  it "shows 1 pending count when one under review proposal exists" do
    Factory.create(:proposal, :status => 'under review')
    Proposal.pending_count.should == 1
  end

  it "shows 0 pending count if one accepted and one reject proposal exist" do
    ['accepted', 'rejected'].each {|status|
      Factory.create :proposal, :status => status
    }
    Proposal.pending_count.should == 0
  end

  it "starts with 0 appeal ratings" do
    Proposal.new.rate_average(false, :appeal).should == 0.0
  end

  it "has up to 5 appeal rating level" do
    Proposal.max_stars.should == 5
  end

  it "cannot have an appeal rating greater than 5" do
    Factory(:proposal).rate(6, reviewer, :appeal).should be_false
  end

  context "stores ratings" do
    let (:prop) {
      Factory(:proposal).tap{ |p|
        p.rate(3, reviewer, :appeal)
        p.save
      }
    }

    it "knows who rated" do
      prop.raters(:appeal).should == User.find(:all)
    end

    it "knows the rating" do
      prop.rate_average(false, :appeal).should == 3.0
    end
  end

  context "comments" do
    let(:proposal){ Factory(:proposal) }
    before do
      proposal.comments.create(:title => "foo", :comment => "comment1", :user => user)
      proposal.comments.create(:title => "bar", :comment => "comment2", :user => user)
      proposal.save
    end
    describe "commenting" do
      specify {proposal.comments.all.size.should == 2}
      specify {Proposal.find_comments_by_user(user).size.should == 2}
      specify {proposal.comments_by_user(user).size.should == 2}
    end
  end

  context "groups comments and ratings" do
    let(:proposal){
      Factory(:proposal).tap{ |p|
        p.comments.create!(:title => 'foo', :comment => 'bar', :user => user)
        p.rate(2, user, :appeal)
        p.rate(3, reviewer, :appeal)
        p.comments.create!(:title => 'hey', :comment => 'now', :user => admin)
      }
    }

    describe "by user id" do
      specify {
        hash = proposal.comments_and_appeal_ratings
        hash[user][:rating].stars.should == 2
        check_one_comment_list hash[user][:comments], 'foo', 'bar'
        hash[reviewer][:rating].stars.should == 3
        check_one_comment_list hash[admin][:comments], 'hey', 'now'
      }
    end

    def check_one_comment_list(comment_list, title, text)
      comment_list.size.should == 1
      comment_list.first.tap{|comment|
        comment.title.should == title
        comment.comment.should == text
      }
    end
  end

  it "knows current proposals" do
    p1 = Factory(:proposal)
    Factory(:proposal, :created_at => DateTime.parse('July 6, 2010'))
    Proposal.current.should == [p1]
  end

  context "CSV export" do
    NUM_STATIC_PROPOSAL_CSV_FIELDS = 8

    let(:proposal1){ Factory(:proposal) }

    let(:proposal2){
      Factory(:proposal).tap{ |p|
        p.rate(1, reviewer, :appeal)
        p.rate(2, alternate_reviewer, :appeal)
      }
    }

    let(:proposal3){
      Factory(:proposal).tap{ |p|
        p.rate(3, alternate_reviewer2, :appeal)
      }
    }

    let(:proposal4){
      Factory(:proposal, :created_at => DateTime.parse('July 6, 2010')).tap{ |p|
        p.rate(3, alternate_reviewer3, :appeal)
      }
    }

    let(:proposal5){
      Factory(:proposal).tap{ |p|
        p.comments.create(:title => "foo", :comment => "comment1", :user => alternate_reviewer2)
#        p.rate(4, alternate_reviewer3, :appeal)
      }
    }

    before do
      proposal1
      proposal2
      proposal3
      proposal3.talk.speakers << [Factory(:workshop_speaker)]

      proposal4.status = "accepted"
      proposal4.save
    end

    it "Should create a sorted list of unique reviewers for pending proposals" do
      pending = Proposal.pending
      reviewers = Proposal.sorted_reviewers(pending)
      reviewers.length.should == 3
      reviewers[0].should == "alternate_reviewer"
      reviewers[1].should == "alternate_reviewer2"
      reviewers[2].should == "reviewer"
    end

    it "Should return a user rating for a user that reviewed a proposal" do
      user_rating = Proposal.user_rating("alternate_reviewer", proposal2.comments_and_appeal_ratings)
      user_rating.should == "2"
    end

    it "Should return an empty string for a user that did not review a proposal" do
      user_rating = Proposal.user_rating("alternate_reviewer2", proposal2.comments_and_appeal_ratings)
      user_rating.should == ""
    end

    it "Should return an empty string for a user that commented but did not review a proposal" do
      user_rating = Proposal.user_rating("alternate_reviewer2", proposal5.comments_and_appeal_ratings)
      user_rating.should == ""
    end

    it "Should create a CSV header array for pending proposals" do
      pending = Proposal.pending
      reviewers = Proposal.sorted_reviewers(pending)
      header = Proposal.pending_csv_header_values(reviewers)
      header.should == ["title", "status", "speaker", "sp1 first name", "sp1 last name",
        "sp1 company", "sp1 email", "sp1 twitter id", "alternate_reviewer",
        "alternate_reviewer2", "reviewer"]
    end

    it "Should create a CSV data array for a pending proposal" do
      pending = Proposal.pending
      reviewers = Proposal.sorted_reviewers(pending)

      data = Proposal.pending_csv_data_values(proposal1, reviewers)
      data.should == ["Sample Talk", "submitted", "Earl Grey", "Earl", "Grey", "Twinings",
        "earl@grey.com", "earlofgrey", "", "", ""]

      data = Proposal.pending_csv_data_values(proposal2, reviewers)
      data.should == ["Sample Talk", "submitted", "Earl Grey",  "Earl", "Grey", "Twinings",
        "earl@grey.com", "earlofgrey", "2", "", "1"]

      data = Proposal.pending_csv_data_values(proposal3, reviewers)
      data.should == ["Sample Talk", "submitted", "Earl Grey;Charlie Sheen",  "Earl", "Grey", "Twinings",
        "earl@grey.com", "earlofgrey", "", "3", ""]
    end

    it "Should generate CSV with quotes around data values" do
      expected_rows = 4
      number_of_reviewers = 3

      csv = Proposal.all_to_csv
      csv.length.should > 0
      csv.count(",").should ==
        expected_rows * ((NUM_STATIC_PROPOSAL_CSV_FIELDS + number_of_reviewers) - 1)
      csv.count('"').should ==
        expected_rows * ((NUM_STATIC_PROPOSAL_CSV_FIELDS + number_of_reviewers) * 2)
    end

    it "Should generate CSV for all proposals in the current year" do
      csv = Proposal.all_to_csv
      arr_of_proposals = FasterCSV.parse(csv)

      arr_of_proposals.length.should == 4
      header_row = arr_of_proposals[0]
      number_of_reviewers = 3
      header_row.length.should ==
        (NUM_STATIC_PROPOSAL_CSV_FIELDS + number_of_reviewers)

      # Test that proposals are ordered by status.
      data_row_1 = arr_of_proposals[1]
      data_row_1[1].should == "submitted"
      data_row_2 = arr_of_proposals[2]
      data_row_2[1].should == "under review"
      data_row_3 = arr_of_proposals[2]
      data_row_3[1].should == "under review"
    end
  end

  describe '#accepted?' do
    it 'returns true when the status is accepted' do
      subject.status = 'accepted'
      subject.accepted?.should be_true
    end

    it 'returns false when the status is not accepted' do
      subject.status = 'rejected'
      subject.accepted?.should be_false
    end
  end

  describe '#rejected?' do
    it 'returns true when the status is rejected' do
      subject.status = 'rejected'
      subject.rejected?.should be_true
    end

    it 'returns false when the status is not rejected' do
      subject.status = 'accepted'
      subject.rejected?.should be_false
    end
  end
end
