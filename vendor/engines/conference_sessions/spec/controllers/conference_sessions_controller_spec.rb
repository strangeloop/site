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
end
