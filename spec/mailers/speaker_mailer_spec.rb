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
    email.from[0].should == "notifications@strangeloop.com"
    email.cc[0].should == sub_admin1.email
    email.cc[1].should == sub_admin2.email
    [/#{talk.speakers[0].first_name}/,
     /#{talk.speakers[0].last_name}/,
     /#{talk.title}/,
     /#{talk.abstract}/,
     /#{talk.talk_length}/,
     /#{talk.comments}/].each do |text|
      assert email.body =~ text
    end
  end
end
