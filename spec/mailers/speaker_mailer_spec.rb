require "spec_helper"

describe SpeakerMailer do

  context "Should send an email"
  before do
    @talk = Factory(:talk)
    @email = SpeakerMailer.talk_submission_email(@talk).deliver

  end

  #There's a shoulda matcher for this, need to figure out how it works
  #and switch to it

  it "should have one email queued for delivery" do
    !ActionMailer::Base.deliveries.size.should == 1
    @email.to[0].should == @talk.speakers[0].email
    @email.from[0].should == "notifications@strangeloop.com"
    [/#{@talk.speakers[0].first_name}/,
     /#{@talk.speakers[0].last_name}/,
     /#{@talk.title}/,
     /#{@talk.abstract}/,
     /#{@talk.talk_length}/,
     /#{@talk.comments}/].each do |text|
      assert @email.body =~ text
    end
  end
end
