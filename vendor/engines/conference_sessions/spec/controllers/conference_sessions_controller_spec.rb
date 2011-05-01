require 'spec_helper'

describe ConferenceSessionsController do
  let(:session) { Factory(:keynote_session) }
  let(:talk) { session.talk }
  let(:speaker) { talk.speakers.first }
  let(:last_years_session) { Factory(:last_years_talk_session) }

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

  context "index action" do
    it "loads current year sessions by default" do
      session #load a current year session
      get :index
      controller.conference_sessions.should == [session]
    end

    context "discriminates on conf_year" do
      before { last_years_session }

      context "this years session" do
        before { get :index }
        it "loads empty array if only previous sessions defined and no year is supplied in the url parameter" do
          controller.conference_sessions.should be_empty
        end

        it "#year defaults to current year" do
          controller.year.should == Time.now.year
        end
      end

      context "last years session" do
        before { get :index, :year => Time.now.year - 1 }

        it "loads a specific year conference session when a year parameter is supplied" do
          controller.conference_sessions.should == [last_years_session]
        end

        it '#year gets its year from the year param' do
          controller.year.should == Time.now.year - 1
        end
      end
    end
  end
end
