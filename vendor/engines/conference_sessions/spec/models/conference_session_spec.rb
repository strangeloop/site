require 'spec_helper'

describe ConferenceSession do

  def reset_conference_session(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @conference_session.destroy! if @conference_session
    @conference_session = ConferenceSession.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_conference_session
  end

  context "validations" do
    
    it "rejects empty title" do
      ConferenceSession.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_conference_session
      ConferenceSession.new(@valid_attributes).should_not be_valid
    end
    
  end

end