require 'spec_helper'

describe Talk do
  [:title, :abstract].each do |field| 
    it {should validate_presence_of field}
  end

  context "Tests needing a basic record to exit" do
    before do
      @model = Talk.create(:title => "a",
                           :abstract => "b",
                           :video_approval => "Yes",
                           :talk_type => "Intro",
                           :track => "JVM",
                           :talk_length => "5 Minutes")
    end

    it "should auto add the current year as conf_year" do
      @model.conf_year.should == Time.now.year
    end

  end

  it {should have_and_belong_to_many :speakers}

  [:abstract, :prereqs, :comments, :av_requirement].each do |field|
    it {should have_db_column(field).of_type(:text)}
  end

  
  def self.test_enum_fields(enum_field_hash)
    enum_field_hash.each_pair do |enum, field |
      enum.each do |enum_field|
        it { should allow_value(enum_field).for(field)}
        it { should_not allow_value("chinaski").for(field) }
      end
    end
  end
    
  test_enum_fields( {Talk.video_approvals => :video_approval,
                      Talk.talk_types => :talk_type,
                      Talk.tracks => :track,
                      Talk.talk_lengths => :talk_length })
  
end
