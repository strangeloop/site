require 'spec_helper'

describe AttendeesHelper do
  let(:attendee) {Factory(:attendee)}

  context ".full_name" do
    it "retrieves a full name from a user" do
      full_name(attendee.user).should eq('Kaiser Von Sozhay')
    end

    it "returns an empty string if no attendee is found for the user" do
      full_name(Factory(:admin)).should eq('')
    end
  end

  context '.schedule_partial' do
    class MockView < ActionView::Base
      include AttendeesHelper
    end

    let(:view) { MockView.new }

    it "returns partial name for unpopulated attendee schedule when current user is not the attendee" do
      view.stub(:current_user) { :foo }
      view.schedule_partial(attendee).should eq('no_schedule_visitor')
    end

    it "returns partial name for unpopulated attendee schedule when current user is the attendee" do
      view.stub(:current_user) { attendee.user }
      view.schedule_partial(attendee).should eq('no_schedule')
    end

    it "returns partial name when attendee schedule has sessions" do
      attendee = Factory(:attendee, :conference_sessions => [Factory(:scheduled_talk_session_for_this_year)])
      view.schedule_partial(attendee).should eq('populated_schedule')
    end
  end
end
