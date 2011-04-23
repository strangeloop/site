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

end
