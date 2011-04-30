require 'spec_helper'

describe ConferenceSessionsHelper do
  #class MockView < ActionView::Base
    #include ApplicationHelper
    #include ConferenceSessionsHelper
  #end

  #let(:view) { MockView.new }
  
  context "#image_tag_for" do
    let(:medium_default_image) { /<img alt="Attendees" src="\/images\/attendees\.jpeg\?[\d]+" \/>/ }

    it "returns default image tags on nil" do
      image_tag_for.should match(medium_default_image)
    end

    it "returns the default image for nil image and medium size" do
      image_tag_for(nil, :medium).should match(medium_default_image)
    end

    it "supports small default images" do
      image_tag_for(nil, :small).should match(/<img alt="Attendees-small" src="\/images\/attendees-small\.jpeg\?[\d]+" \/>/)
    end
    
    #it "returns datastore-backed image tags" do
      #view.image_tag_for(Factory(:image)).should match(medium_default_image)
    #end
  end
end
