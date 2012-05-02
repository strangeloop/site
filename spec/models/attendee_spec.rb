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

describe Attendee do
  let(:attendee) { Factory(:attendee) }
  let(:registered_attendee) { Factory(:registered_attendee) }

  [:first_name, :last_name, :email, :reg_id].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :attendee_cred}

  context "protected attributes" do
    [ :reg_id, :attendee_cred_id, :conf_year].each do |field|
      it {should protect_attribute(field, 'foo')}
      end

    it {should protect_attribute(:conf_year, 1400)}
  end

  [:middle_name, :city, :state, :country, :email,
   :twitter_id, :blog_url, :company].each do |field|
    it {should have_db_column(field).of_type(:string)}
  end

  context "testing uniqueness" do
    before do
      Factory(:attendee)
    end
    it {should validate_uniqueness_of :email}
    it {should validate_uniqueness_of :twitter_id}

    it "allows nil for twitter_id" do
      2.times{ Factory(:attendee, :twitter_id => nil).should be_valid}
    end
  end

  it "strips @ symbol from twitter id" do
    Attendee.new(:twitter_id => '@mario').twitter_id.should eq('mario')
  end

  it "retrieves attendees by the latest year" do
    previous_conf_attendee = Factory(:attendee, :conf_year => 2010)

    attendee

    Attendee.current_year.should eq([attendee])
  end

  it "joins all names in #full_name" do
    Attendee.new(:first_name => 'Mario',
                 :middle_name => 'Enrique',
                 :last_name => 'Aquino').full_name.should eq('Mario Enrique Aquino')
  end

  let(:session)   { Factory(:scheduled_talk_session_for_this_year) }
  let(:session_2) { Factory(:scheduled_one_thirty_talk_session) }
  let(:session_3) { Factory(:scheduled_two_thirty_talk_session) }
  let(:this_tuesday) { DateTime.parse('Tuesday').strftime('%A, %B %d, %Y') }

  it "toggles session attendence on if it is off" do
    attendee.toggle_session(session.id).should be_true
    attendee.conference_sessions.should eq([session])
  end

  it "toggles session attendence off if it is on" do
    attendee.conference_sessions = [session]
    attendee.toggle_session(session.id).should be_false
    attendee.conference_sessions.should be_empty
  end

  it "returns nil if an invalid session id is given to toggle_session" do
    attendee.toggle_session(-1).should be_nil
  end

  context ".sorted_interested_sessions" do
    it "sorts conference sessions according to session start time" do
      [session_2, session_3, session].each {|s| attendee.conference_sessions << s }
      attendee.sorted_interested_sessions.should eq(
          { this_tuesday => { session.session_time   => [session],
                              session_2.session_time => [session_2],
                              session_3.session_time => [session_3]} } )
    end
  end

  context '#session_calendar' do
    it "is empty when no sessions have been signed up for" do
      attendee.session_calendar.should eq(RiCal.Calendar)
    end

    it "adds signed up sessions to the calendar" do
      attendee.conference_sessions << session
      cal = attendee.session_calendar
      cal.events.size.should eq(1)
      event = cal.events.first
      event.summary.should eq(session.title)
      event.description.should eq(session.description)
      event.dtstart.should eq(session.start_time)
      event.dtend.should eq(session.end_time)
      event.location.should eq(session.location)
      event.url.should eq(session.url)
    end
  end

  let(:test_attendee) do
    a = Attendee.new
    a.first_name= "Ryan"
    a.last_name= "Senior"
    a.reg_id= "112233445566"
    a.city= "St Louis"
    a.state= "MO"
    a.email= "rsenior@revelytix.com"
    a
  end

  it "should create a new attendee if one does not exist" do
    Attendee.existing_attendee?(test_attendee.reg_id).should be_false
    test_attendee.register_attendee
    Attendee.existing_attendee?(test_attendee.reg_id).should be_true
  end

  it "should not create a new attendee if it already exists" do
    Attendee.existing_attendee?(test_attendee.reg_id).should be_false
    test_attendee.register_attendee
    prev_attendee = Attendee.existing_attendee?(test_attendee.reg_id)
    prev_attendee.register_attendee
    curr_attendee = Attendee.existing_attendee?(test_attendee.reg_id)
    prev_attendee.created_at.should == curr_attendee.created_at
    prev_attendee.id.should == curr_attendee.id
  end

end

