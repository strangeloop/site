require 'spec_helper'

describe Talk do
  [:title, :abstract].each do |field| 
    it {should validate_presence_of field}
  end

  context "Tests needing a basic record to exit" do
    before do
      @model = Talk.create(:title => "a",
                           :abstract => "b",
                           :talk_type => :deep)
    end

    it "should auto add the current year as conf_year" do
      @model.conf_year.should == Time.now.year
    end

    it "has a different value fora symbol" do
      @model.talk_type.to_sym == "Deep Dive"
    end

    it "has a different value fora symbol" do
      @model.talk_type= :intro
      @model.talk_type.to_sym == "Intro"
    end

    it "has a different value fora symbol" do
      @model.talk_type = :survey
      @model.talk_type.to_sym == "Survey"
    end

  end

  [:track, :talk_length].each do |field| 
    it {should belong_to field}
  end

  it {should have_and_belong_to_many :speakers}

  [:abstract, :prereqs, :comments, :av_requirement].each do |field|
    it {should have_db_column(field).of_type(:text)}
  end

  [:yes, :no, :maybe].each do |field|
    it { should allow_value(field).for(:video_approval) }
  end

  it "allows only attributes in the enum" do
    lambda do
      should_not allow_value(:chinaski).for(:video_approval)
    end.should raise_error(ArgumentError, ":chinaski is not one of {:maybe, :no, :yes}")
  end
  
  [:deep, :intro, :survey].each do |field|
    it { should allow_value(field).for(:talk_type) }
  end
  
  it "allows only attributes in the enum" do
    lambda do
      should_not allow_value(:chinaski).for(:talk_type)
    end.should raise_error(ArgumentError, ":chinaski is not one of {:deep, :intro, :survey}")
  end
end
