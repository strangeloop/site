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



require "spec_helper"

describe SpeakerMailer do

  context "Should send an email"
  let(:talk){Factory(:talk)}
  let!(:sub_admin1){Factory(:submission_admin1)}
  let!(:sub_admin2){Factory(:submission_admin2)}
  let!(:email){ SpeakerMailer.talk_submission_email(talk).deliver}

  #There's a shoulda matcher for this, need to figure out how it works
  #and switch to it

  it "should have one email queued for delivery" do
    !ActionMailer::Base.deliveries.size.should == 1
    email.to[0].should == talk.speakers[0].email
    email.from[0].should == "notifications@thestrangeloop.com"
    email.cc[0].should == sub_admin1.email
    email.cc[1].should == sub_admin2.email
    [/#{talk.speakers[0].first_name}/,
     /#{talk.title}/,
     /#{talk.abstract}/,
     /#{talk.comments}/].each do |text|
      assert email.body =~ text
    end
  end
end
