require 'spec_helper'

describe Admin::ProposalsHelper do
  class MockView < ActionView::Base
    include Admin::ProposalsHelper
  end

  let(:proposal) { Factory(:proposal) }
  let(:view) { MockView.new }

  it "show a reasonable speakername" do
    view.speaker_for(proposal).should == 'Earl Grey'
  end

  it "shows the title for a talk" do
    view.title_for(proposal).should == 'Sample Talk'
  end
end
  
