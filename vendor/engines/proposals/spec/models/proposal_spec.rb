require 'spec_helper'

describe Proposal do

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
end
