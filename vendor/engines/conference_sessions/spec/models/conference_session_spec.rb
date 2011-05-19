require 'spec_helper'

describe ConferenceSession do
  let(:talk) { Factory(:talk) }
  let(:conference_session) { ConferenceSession.new(:talk => talk) }

  it "should auto add the current year as conf_year" do
    conference_session.conf_year.should == Time.now.year
  end

  context "validations" do
    
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

    %w(workshop keynote talk lightning undefined strange\ passions panel).each do |talk_format|
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

  it "gets its title from its talk" do
    conference_session.title.should == talk.title
  end

  it "knows all conference years on record" do
    Factory(:last_years_talk_session)
    Factory(:talk_session)
    current_year = Time.now.year
    ConferenceSession.all_years.should == [current_year, current_year - 1]
  end

  context "#from_year" do
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
  
  context "CSV export tests" do
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
  	  csv = ConferenceSession.to_csv(2008)
  	  csv.length.should > 0
  	  csv.count(",").should == 11
  	  csv.count('"').should == 24
    end
    
    it "Should generate empty CSV with only a header" do
  	  csv = ConferenceSession.to_csv(2008)  	
  	  arr_of_conference_sessions = FasterCSV.parse(csv)
  	  arr_of_conference_sessions.length.should == 1
    end
  
    it "Should generate CSV with only conference sessions in current year" do  
  	  csv = ConferenceSession.to_csv()  	  
  	  arr_of_conference_sessions = FasterCSV.parse(csv)
  	  arr_of_conference_sessions.length.should == 3
    end
    
    it "Should generate CSV with only conference sessions in 2010" do  
  	  csv = ConferenceSession.to_csv(2010)
  	  
  	  arr_of_conference_sessions = FasterCSV.parse(csv)
  	  arr_of_conference_sessions.length.should == 2
  	  
  	  first_data_row = arr_of_conference_sessions[1]
  	  conf_year = first_data_row[0]
  	  conf_year.should == "2010"
    end
  end
  
end

