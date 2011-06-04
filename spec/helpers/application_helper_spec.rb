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

describe ApplicationHelper do
  context '#link_tree' do
    it "is empty when no pages are supplied" do
      link_tree.should be_empty
    end

    def make_parent(parent, *children)
      p = double(parent)
      p.stub(:children).and_return(children)
      p
    end

    let(:childless_links) do 
      %w[a b c d e f g h].map do |item|
        make_parent(item)
      end
    end

    it "groups childless parents in sevens" do
      sorted = link_tree(childless_links)
      sorted.size.should == 2
      sorted[0].size.should == 7
      sorted[1].size.should == 1
    end

    it "groups parent and childless links in sevens" do
      pages = [make_parent("p1", *%w[c1 c2 c3])].concat(childless_links)
      sorted = link_tree(pages)
      sorted.size.should == 2
      sorted[0].size.should == 4
      sorted[1].size.should == 5
    end
  end

  context "#twitter_link" do
    it "returns a link when a string is passed" do
      twitter_link('foo').should == "<a href=\"http://twitter.com/foo\"><strong>@foo</strong></a>"
    end

    it "supports a supplied content tag for the twitter name" do
      twitter_link('foo', :fart).should == "<a href=\"http://twitter.com/foo\"><fart>@foo</fart></a>"
    end

    it "retuns nil if no twitter id is supplied" do
      twitter_link.should be_nil
    end

    it "returns nil if an empty string is supplied for twitter id" do
      twitter_link(nil).should be_nil
    end
  end

  context "#image_tag_for" do
    #class MockView < ActionView::Base
      #include ApplicationHelper
    #end

    #let(:view) { MockView.new }

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
