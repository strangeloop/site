require 'spec_helper'

describe Speaker do
  [:first_name, :last_name, :email, :bio].each do |field| 
    it {should validate_presence_of field}
  end

  it {should allow_value("MO").for(:state)}
  it {should allow_value("IL").for(:state)}
  it {should allow_value("CA").for(:state)}
  it {should_not allow_value("ZZ").for(:state)}

  it {should allow_value("US").for(:country)}
  it {should allow_value("CA").for(:country)}
  it {should_not allow_value("ZZ").for(:country)}

  context "Tests needing a basic record to exist" do
  before do
      @model = Speaker.create(:first_name => "a",
                              :last_name => "b",
                              :email  => "c",
                              :phone => "d",
                              :bio => "e",
                              :state => "MO",
                              :country => "US",
                              :phone => "111-111-1111")
    end

    it "should auto add the current year as conf_year" do
      @model.conf_year.should == Time.now.year
    end
  end

  it {should allow_value("123-456-7891").for(:phone)}
  it {should allow_value("1234567891").for(:phone)}
  it {should_not allow_value("123-7891").for(:phone)}
end
