require 'spec_helper'

describe ConferenceSession do
  let(:talk) { Factory(:talk) }
  let(:conference_session) { ConferenceSession.new(:talk => talk) }

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

    %w(workshop keynote talk lightning undefined).each do |talk_format|
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
end

