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

  [:first_name, :last_name, :email, :reg_id].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :attendee_cred}

  context "protected attributes" do
    [ :reg_id, :acct_activation_token,
      :attendee_cred_id, :conf_year].each do |field|
      it {should protect_attribute(field, 'foo')}
      end

    it {should protect_attribute(:token_created_at, Time.now)}
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
    it {should validate_uniqueness_of :acct_activation_token}
    it {should validate_uniqueness_of :twitter_id}

    it "allows nil for twitter_id and acct_activation_token" do
      2.times{ Factory(:attendee, :acct_activation_token => nil, :twitter_id => nil).should be_valid}
    end
  end

  it "strips @ symbol from twitter id" do
    Attendee.new(:twitter_id => '@mario').twitter_id.should eq('mario')
  end

  it {should have_db_column(:token_created_at).of_type(:datetime)}

  let(:attendee) { Factory(:attendee) }
  let(:registered_attendee) { Factory(:registered_attendee) }

  it "should decrypt encrypted strings" do
    encrypted_txt = attendee.activation_token
    encrypted_txt.should_not ==  "#{attendee.email}|#{attendee.acct_activation_token}|#{attendee.token_created_at}"
    decrypted_txt = Attendee.decrypt_token CGI.unescape(encrypted_txt)
    decrypted_txt.should ==  [attendee.email,attendee.acct_activation_token,attendee.token_created_at.to_s]
  end

  it "should pass an auth check for a known users" do
    token = CGI.unescape attendee.activation_token
    Attendee.check_token(token).should be_true
  end

  it "should fail on incorrect uids" do
    attendee.acct_activation_token = "foo"
    token = CGI.unescape attendee.activation_token
    Attendee.check_token(token).should be_false
  end

  it "should fail on incorrect date" do
    token = CGI.unescape attendee.activation_token
    attendee.token_created_at = DateTime.parse('1985-10-25')
    attendee.save!
    Attendee.check_token(token).should be_false
  end

  it "should fail on incorrect email" do
    attendee.email = "something@different.net"
    token = CGI.unescape attendee.activation_token
    Attendee.check_token(token).should be_false
  end

  it "should generate an activation token upon save" do
    activation_token = attendee.acct_activation_token
    attendee.save!
    activation_token.should != attendee.acct_activation_token
  end

  it "retrieves registered attendees who have a null activation token" do
    attendee

    registered_attendee

    Attendee.registered.should eq([registered_attendee])
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

  let(:service){ Service.new(:uemail => 'henry@chinaski.com',
                             :uid => 'Henry',
                             :provider => 'Google',
                             :uname => 'Henry Chinaski')}
  let(:nrattendee){Factory(:not_registered_attendee)}

  context "activating an attendee" do
    before do
      nrattendee.activate(service)
    end
    it "should save activated info, clear activation tokens" do
      a = Attendee.find(nrattendee.id)
      cred = a.attendee_cred
      svc = a.attendee_cred.services.first

      cred.should_not be_nil
      cred.email.should == a.email
      cred.encrypted_password.should_not be_nil

      a.acct_activation_token.should be_nil
      a.token_created_at be_nil

      cred.services.size == 1
      svc.uemail.should == 'henry@chinaski.com'
      svc.uid.should == 'Henry'
      svc.provider.should == 'Google'
      svc.uname.should == 'Henry Chinaski'
    end

  end

  let(:service2){ Service.new(:uemail => 'henry2@chinaski.com',
                              :uid => 'Henry2',
                              :provider => 'Google',
                              :uname => 'Henry Chinaski')}

  context "activating an attendee" do
    before do
      attendee.activate(service2)
    end
    it "should not create a new attendee_cred if one already exists" do
      a = Attendee.find(attendee.id)
      cred = a.attendee_cred

      cred.email.should eq(a.email)
      cred.encrypted_password.should_not be_nil

      a.acct_activation_token.should be_nil
      a.token_created_at be_nil

      cred.services.size == 1
      a.attendee_cred.services.first.should eq(service2)
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

  it "should reset token for an existing attendee" do
    attendee.acct_activation_token.should_not be_nil
    attendee.token_created_at.should_not be_nil

    old_token = attendee.acct_activation_token
    old_created_dt = attendee.token_created_at

    attendee.reset_token

    old_token.should_not == attendee.acct_activation_token
    old_created_dt.should_not == attendee.token_created_at
  end

  it "should raise an exception when attendee does not have a token" do
    attendee.acct_activation_token= nil
    lambda{attendee.activation_token}.should raise_error
  end

  it "should raise an exception when attendee does not have a token creation date" do
    attendee.token_created_at= nil
    lambda{attendee.activation_token}.should raise_error
  end

  it "should raise an exception when attendee does not have an email" do
    attendee.email= nil
    lambda{attendee.activation_token}.should raise_error
  end

end

