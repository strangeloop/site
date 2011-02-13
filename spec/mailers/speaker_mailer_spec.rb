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
    assert @email.body =~ /#{@talk.speakers[0].first_name}/
    assert @email.body =~ /#{@talk.speakers[0].last_name}/
    assert @email.body =~ /Thank you for your Strange Loop.*submission/
    assert @email.body =~ /#{@talk.title}/
    assert @email.body =~ /#{@talk.abstract}/
    assert @email.body =~ /#{@talk.talk_length}/
    assert @email.body =~ /#{@talk.comments}/
  end
end
