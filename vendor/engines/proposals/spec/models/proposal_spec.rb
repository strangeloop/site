require 'spec_helper'

describe Proposal do

  def reset_proposal(options = {})
    @valid_attributes = {
      :id => 1,
      :status => 'submitted'
    }

    @proposal.destroy! if @proposal
    @proposal = Proposal.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_proposal
  end

  context "validations" do
    
    it "rejects empty status" do
      Proposal.new(@valid_attributes.merge(:status => "")).should_not be_valid
    end

    it "rejects invalid status" do
      Proposal.new(@valid_attributes.merge(:status => 'heynow')).should_not be_valid
    end
    
  end

end
