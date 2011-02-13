require 'spec_helper'

describe Refinery::Proposals::Engine do
  describe "Plugin#title" do
    let(:title) { 
      Refinery::Plugins.registered.find{|p| "proposals" == p.name}.title
    }

    context "no pending proposals" do
      before (:each) do
        Proposal.stub(:pending_count).and_return(0)
      end

      it "responds to title" do
        title.should_not be_nil
      end

      it "have no numeric suffix by default" do
        title.should_not =~ /\w\s\(/
      end
    end

    it "show a numeric suffix if there are proposals in a pending state" do
      Proposal.stub(:pending_count).and_return(2)
      title.should =~ /\w\s\(2\)/
    end
  end
end
