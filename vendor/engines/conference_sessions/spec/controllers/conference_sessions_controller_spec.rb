#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



require 'spec_helper'

describe ConferenceSessionsController do
  let(:session) { Factory(:keynote_session) }
  let(:talk) { session.talk }
  let(:speaker) { talk.speakers.first }
  let(:last_years_session) { Factory(:last_years_talk_session) }
  let(:attendee) { Factory(:registered_attendee) }

  describe "show action" do
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

  describe "index action" do
    it "loads current year sessions by default" do
      session #load a current year session
      get :index
      controller.sessions_from_year.should == [session]
    end    
    context "discriminates on conf_year" do
      before { last_years_session }

      context "this years session" do
        before { get :index }
        it "loads empty array if only previous sessions defined and no year is supplied in the url parameter" do
          controller.sessions_from_year.should be_empty
        end

        it "#year defaults to current year" do
          controller.year.should == Time.now.year
        end
      end

      context "last years session" do
        before { get :index, :year => Time.now.year - 1 }

        it "loads a specific year conference session when a year parameter is supplied" do
          controller.sessions_from_year.should == [last_years_session]
        end

        it '#year gets its year from the year param' do
          controller.year.should == Time.now.year - 1
        end
      end
    end
  end

  describe "authenticated action" do
    before(:each) do
      #Must create an attendee record to prevent refinery
      #from redirecting to welcome page
      Factory.create(:admin)
      @request.env['devise.mapping'] = :admin
      sign_in attendee.attendee_cred
    end

    it "#toggle_session passes session_id to an attendee for update" do
      controller.attendee.should_receive(:toggle_session).with(1).and_return(true)
      put :toggle_session, :sessionid => "1"
      ActiveSupport::JSON.decode(response.body).should eq(ActiveSupport::JSON.decode({:willAttend => true}.to_json))
    end

    context "#attendee_session_ids" do
      it "returns an empty array if the attendee is not interested in any sessions" do
        controller.attendee_session_ids.should be_empty
      end

      it "returns the sessions ids this attendee is interested in" do
        session1 = Factory(:scheduled_talk_session_for_this_year)
        session2 = Factory(:scheduled_talk_session_for_this_year, :room => Factory(:small_room))
        controller.attendee.conference_sessions = [session1, session2]
        controller.attendee_session_ids.should eq([session1.id, session2.id])
      end
    end
  end

  it "#attendee_session_ids returns an empty array if not signed in" do
    controller.attendee_session_ids.should be_empty
  end
end
