require 'spec_helper'

describe ConferenceSessionsController do
  let(:session) { Factory(:keynote_session) }
  let(:talk) { session.talk }
  let(:speaker) { talk.speakers.first }

  context "show action" do
   before { get :show, :id => session.friendly_id }

    it "exposes a specific conference session" do
      controller.conference_session.should == session
    end

    it "exposes the talk for the session" do
      controller.talk.should == talk
    end

    it "exposes the speaker for the talk" do
      controller.speaker.should == speaker
    end
  end
end
