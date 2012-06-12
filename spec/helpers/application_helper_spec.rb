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
  describe '#link_tree' do
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

  describe "#twitter_link" do
    it "returns a link when a string is passed" do
      twitter_link('foo').should == "<a href=\"https://twitter.com/foo\"><strong>@foo</strong></a>"
    end

    it "supports a supplied content tag for the twitter name" do
      twitter_link('foo', :fart).should == "<a href=\"https://twitter.com/foo\"><fart>@foo</fart></a>"
    end

    it "returns nil if no twitter id is supplied" do
      twitter_link.should be_nil
    end

    it "returns nil if an empty string is supplied for twitter id" do
      twitter_link(nil).should be_nil
    end
  end

  describe "#github_link" do
    it "returns a link when a string is passed" do
      github_link('foo').should == "<a href=\"https://github.com/foo\"><strong>foo</strong></a>"
    end

    it "returns nil if no github id is supplied" do
      github_link.should be_nil
    end

    it "returns nil if an empty string is supplied for github id" do
      github_link(nil).should be_nil
    end
  end

  describe "#workforpie_link" do
    it "returns a link when a string is passed" do
      work_for_pie_link('foo').should == "<a href=\"http://workforpie.com/foo\"><strong>foo</strong></a>"
    end

    it "returns nil if no workforpie id is supplied" do
      work_for_pie_link.should be_nil
    end

    it "returns nil if an empty string is supplied for workforpie id" do
      work_for_pie_link(nil).should be_nil
    end
  end

  describe "#image_tag_for" do
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

  describe '#time_period_for_sessions' do
    let(:time_period) { mock 'time period' }
    let(:one) { mock('one', :session_time => time1) }
    let(:two) { mock('two', :session_time => time2) }
    let(:three) { mock('three', :session_time => time3) }
    let(:time1) { Factory(:session_time, :duration_hours => 0, :duration_minutes => 30) }
    let(:time2) { Factory(:session_time, :duration_hours => 0, :duration_minutes => 50) }
    let(:time3) { Factory(:session_time, :duration_hours => 0, :duration_minutes => 45) }
    let(:room_sessions) { {'one' => [one], 'two' => [two], 'three' => [three] } }


    it 'returns the period for the longest session passed in' do
      two.stub_chain(:session_time, :time_period).and_return(time_period)
      helper.time_period_for_sessions(room_sessions).should == time_period
    end
  end

  let(:helper) { Object.new.extend ApplicationHelper }
  let(:session) { mock('session') }

  it "considers sessions without tracks non-technical" do
    session.should_receive(:track)
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions without a format non-technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format)
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions with 'miscellaneous' format non-technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format).twice.and_return('miscellaneous')
    helper.is_technical_track?(session).should be_false
  end

  it "considers sessions with track and non-miscellaneous format technical" do
    session.should_receive(:track).and_return(true)
    session.should_receive(:format).twice.and_return('foo')
    helper.is_technical_track?(session).should be_true
  end

  it "#time_column_height calculates for various session sizes" do
    helper.time_column_height(1).should == 250
    helper.time_column_height(2).should == 530
    helper.time_column_height(3).should == 870
    helper.time_column_height(4).should == 1240
    helper.time_column_height(5).should == 1550
    helper.time_column_height(6).should == 1920
    helper.time_column_height(7).should == 2240
    helper.time_column_height(8).should == 2560
  end

  it "exposes a key for authenticated attendee sessions" do
    helper.stub(:current_attendee_cred).and_return('foo')
    helper.schedule_key.should eq('auth-schedule')
  end

  it "exposes a key for unauthenticated attendee sessions" do
    helper.stub(:current_attendee_cred).and_return(nil)
    helper.schedule_key.should eq('schedule')
  end

  it "only shows schedule selection for the right key" do
    helper.show_schedule_selection?('auth-schedule').should be_true
  end

  it "denies schedule selection for a non-auth key" do
    helper.show_schedule_selection?.should be_false
    helper.show_schedule_selection?('schedule').should be_false
  end
end
