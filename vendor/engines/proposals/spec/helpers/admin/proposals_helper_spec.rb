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

  it "show the track" do
    view.track_for(proposal).should == 'JVM'
  end

  it "shows the title for a talk" do
    view.title_for(proposal).should == 'Sample Talk'
  end

  describe "#display_for(:role)" do
    context "when the current user has the role" do 
      it "displays the content" do
        user = stub('User', :has_role? => true) 
        helper.stub(:current_user).and_return(user) 
        content = helper.display_for(:existing_role) {"content"} 
        content.should == "content"
      end 
    end
  end
end
  
