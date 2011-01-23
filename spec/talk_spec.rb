require 'spec_helper'

describe Talk do
  [:title, :abstract].each do |field| 
    it {should validate_presence_of field}
  end

  context "Tests needing a basic record to exit" do
    before do
      @model = Talk.create(:title => "a",
                           :abstract => "b")

    end

    it "should auto add the current year as conf_year" do
      @model.conf_year.should == Time.now.year
    end
  end

  [:talk_type, :track, :talk_length, :video_approval].each do |field| 
    it {should belong_to field}
  end

  it {should have_and_belong_to_many :speakers}

  [:abstract, :prereqs, :comments, :av_requirement].each do |field|
    it {should have_db_column(field).of_type(:text)}
  end

end
