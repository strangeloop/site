require 'spec_helper'

describe SessionTime do
  its "title contains start and end time" do
    Factory(:session_time).title.should eq('Tuesday from 12:30 to 01:30 PM')
  end
end
