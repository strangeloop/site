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

end
