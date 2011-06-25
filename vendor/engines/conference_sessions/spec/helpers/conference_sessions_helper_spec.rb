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

describe ConferenceSessionsHelper do
  let(:helper) { Object.new.extend ConferenceSessionsHelper }
  let(:session) { mock('session') }

  it "considers sessions without tracks non-technical" do
    session.should_receive(:track)
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions without a format non-technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format)
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions with 'miscellaneous' format non-technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format).twice.and_return('miscellaneous')
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions with track and non-miscellaneous format technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format).twice.and_return('foo')
    helper.is_technical_track?(session).should be_true
  end
end
