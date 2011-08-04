require "spec_helper"

describe AttendeeMailer do

  context "Should send an email"
  let(:attendee){Factory(:attendee)}
  let!(:email){ AttendeeMailer.attendee_activation_email(attendee).deliver}

  it "should have one email queued for delivery" do
    !ActionMailer::Base.deliveries.size.should == 1
    email.to[0].should == attendee.email
    email.from[0].should == "notifications@thestrangeloop.com"
    assert email.body.include?(attendee.first_name)
    assert email.body.include?(attendee.activation_token)
    puts attendee.activation_url
    puts email.body
    assert email.body.include?(attendee.activation_url)
  end
end
