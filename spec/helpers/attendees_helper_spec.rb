require 'spec_helper'

describe AttendeesHelper do
  let(:attendee) {Factory(:attendee)}
  it "retrieves a full name from a user" do
    full_name(attendee.user).should eq('Kaiser Von Sozhay')
  end

  it "returns an empty string if no attendee is found for the user" do
    full_name(Factory(:admin)).should eq('')
  end
end
