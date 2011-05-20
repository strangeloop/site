require 'spec_helper'

describe Proposal do

  let(:reviewer) {Factory(:reviewer)}
  let(:user){Factory(:user)}
  let(:admin){Factory(:admin)}
  

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
      p.talk = Talk.new(:title => 'Writing a conf site', 
                        :abstract => 'Moar codez')
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
  
  context "CSV export" do
    NUM_CSV_FIELDS = 12
  
    before do
      # This talk will be in submitted status
      talk = Factory(:talk)
      proposal = Factory(:proposal, :talk => talk)
      proposal.save
      
       # This talk will be in submitted status
      talk = Factory(:talk)
      proposal = Factory(:proposal, :talk => talk)
      proposal.save
      
      talk = Factory(:talk)
      proposal = Factory(:proposal, :talk => talk)
      proposal.status = 'under review'
      proposal.save
    end
    
    it "Should generate CSV with quotes around data values" do
      csv = Proposal.to_csv('non existent status')
      csv.length.should > 0   
      csv.count(",").should == NUM_CSV_FIELDS - 1
      csv.count('"').should == NUM_CSV_FIELDS * 2
    end
    
    it "Should generate empty CSV with only a header" do
  	  csv = Proposal.to_csv('non existent status')  	
  	  arr_of_conference_sessions = FasterCSV.parse(csv)
  	  arr_of_conference_sessions.length.should == 1
    end
  
    it "Should generate CSV with only submitted proposals" do
      csv = Proposal.to_csv('submitted')
      arr_of_proposals = FasterCSV.parse(csv)
      arr_of_proposals.length.should == 3
  
      first_data_row = arr_of_proposals[1]
      status = first_data_row[0]
      status.should == 'submitted'
      
      first_data_row = arr_of_proposals[2]
      status = first_data_row[0]
      status.should == 'submitted'
    end
    
    it "Should generate CSV with only proposals under review" do
      csv = Proposal.to_csv('under review')
      arr_of_proposals = FasterCSV.parse(csv)
      arr_of_proposals.length.should == 2
  
      first_data_row = arr_of_proposals[1]
      status = first_data_row[0]
      status.should == 'under review'
    end
  end
  
end
