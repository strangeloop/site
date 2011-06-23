require 'spec_helper'

describe Track do
  it "invalid without a name" do
    Track.new.should_not be_valid
  end

  it "is valid with only a name" do
    Track.new(:name => 'foo').should be_valid
  end

  it "gets a conf_year automatically" do
    Track.create(:name => 'foo').conf_year.should == Time.now.year
  end

  it "has a default color if not is set" do
    Track.new.color.should eq('000')
  end

  it "has a title that matches its name" do
    Track.new(:name => 'Hey').title.should eq('Hey')
  end
end
