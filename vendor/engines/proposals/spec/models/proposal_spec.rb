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
      p.talk = Talk.new(:title => 'Writing a conf site', :abstract => 'Moar codez')
      p.should be_valid
    end
  end
end
