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

describe ConferenceSession do
  let(:talk) { Factory(:talk) }
  let(:conference_session) { ConferenceSession.new(:talk => talk) }

  describe "validations" do

    it "rejects empty format" do
      ConferenceSession.new(:format => '').should_not be_valid
    end

    it "rejects invalid format" do
      ConferenceSession.new(:format => 'heynow').should_not be_valid
    end

    context "the simplest form" do

      it "is valid with just a talk and no format" do
        conference_session.should be_valid
      end

      it 'has an undefined format by default' do
        conference_session.format.should == 'undefined'
      end
    end

    it "is valid with talk and session time" do
      ConferenceSession.new(:talk => talk, :session_time => Factory(:session_time)).should be_valid
    end

    %w(workshop keynote elc talk lightning undefined strange\ passions panel).each do |talk_format|
      context "talk format validation" do
        let(:session) { ConferenceSession.new(:talk => Factory(:talk), :format => talk_format) }
        it "is valid with talk and #{talk_format}" do
          session.should be_valid
        end

        it "knows its format" do
          session.format.should == talk_format
        end
      end
    end
  end

  it {should belong_to :talk}
  it {should belong_to :slides}
  it {should belong_to :session_time}
  it {should belong_to :room}
  it {should belong_to :track}

  it "gets its title from its talk" do
    conference_session.title.should == talk.title
  end

  it "knows all conference years on record" do
    Factory(:last_years_talk_session)
    Factory(:talk_session)
    current_year = Time.now.year
    ConferenceSession.all_years.should == [current_year, current_year - 1]
  end

  describe ".from_year" do
    let(:current_year_session) { Factory(:talk_session) }
    let(:last_years_session) { Factory(:last_years_talk_session) }

    before do
      current_year_session
      last_years_session
    end

    it "defaults to current year" do
      ConferenceSession.from_year.should == [current_year_session]
    end

    it "retrieves sessions based on year param" do
      ConferenceSession.from_year((Time.now.year - 1).to_s).should == [last_years_session]
    end
  end

  describe "CSV export tests" do
    NUM_CONF_SESSION_CSV_FIELDS = 12

    before do
      # This talk will be for the current year.
      talk = Factory(:talk)
      conference_session = Factory(:conference_session, :talk => talk)
      conference_session.save

      # This talk will be for the current year.
      talk = Factory(:talk)
      conference_session = Factory(:conference_session, :talk => talk)
      conference_session.save

      talk = Factory(:talk)
      conference_session = Factory(:conference_session, :talk => talk)
      conference_session.conf_year = 2010
      conference_session.save
    end

    it "Should generate CSV with quotes around data values" do
      # Only the header row should be returned.
      csv = ConferenceSession.to_csv(2008)
      csv.length.should > 0
      csv.count(",").should == 11
      csv.count('"').should == 24
    end

    it "Should generate CSV with only conference sessions in current year" do
      csv = ConferenceSession.to_csv()

      arr_of_conference_sessions = FasterCSV.parse(csv)
      arr_of_conference_sessions.length.should == 3

      header_row = arr_of_conference_sessions[0]
      header_row.length.should == NUM_CONF_SESSION_CSV_FIELDS

      first_data_row = arr_of_conference_sessions[1]
      first_data_row.length.should == NUM_CONF_SESSION_CSV_FIELDS

      conf_year = first_data_row[0]
      conf_year.should == Time.now.year.to_s
    end

    it "Should generate CSV with only conference sessions in 2010" do
      csv = ConferenceSession.to_csv(2010)

      arr_of_conference_sessions = FasterCSV.parse(csv)
      arr_of_conference_sessions.length.should == 2

      header_row = arr_of_conference_sessions[0]
      header_row.length.should == NUM_CONF_SESSION_CSV_FIELDS

      first_data_row = arr_of_conference_sessions[1]
      first_data_row.length.should == NUM_CONF_SESSION_CSV_FIELDS

      conf_year = first_data_row[0]
      conf_year.should == 2010.to_s
    end
  end

  describe ".by_session_time" do
    let(:small_room) { Factory(:small_room) }
    let(:big_room) { Factory(:big_room) }
    let(:evening_session_time) { Factory(:evening_session_time) }
    let(:morning_session_time) { Factory(:morning_session_time) }
    let(:session_time) { Factory(:session_time) }
    let(:fifth) {  Factory(:talk_session, :session_time => evening_session_time, :room => small_room) }
    let(:fourth) { Factory(:talk_session, :session_time => evening_session_time, :room => big_room) }
    let(:third) {  Factory(:talk_session, :session_time => session_time,         :room => small_room) }
    let(:first) {  Factory(:talk_session, :session_time => morning_session_time, :room => big_room) }
    let(:second) { Factory(:talk_session, :session_time => morning_session_time, :room => Factory(:room)) }

    it "sorts by session time then room size" do
      fourth
      fifth
      second
      first
      third

      sessions = ConferenceSession::by_session_time

      sessions.should == {'Thursday, July 01, 2010' => { morning_session_time => [first, second],
        session_time         => [third],
        evening_session_time => [fourth, fifth] }}
    end

    it "ignores all but the most recent years conference sessions" do
      first
      Factory(:talk_session_2009, :session_time => Factory(:session_time_2009), :room => Factory(:room_from_2009))

      ConferenceSession::by_session_time.should == {'Thursday, July 01, 2010' => { morning_session_time => [first] } }
    end

    it "ignores undefined conference sessions" do
      Factory(:conference_session, :talk => Factory(:talk), :session_time => session_time, :room => big_room)

      ConferenceSession::by_session_time.should be_empty
    end
  end
end

