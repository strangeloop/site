require 'spec_helper'

describe Proposal do
  it "requires speakername" do
    Proposal.new().valid?.should be_false
  end
end
