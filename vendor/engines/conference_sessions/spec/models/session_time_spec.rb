require 'spec_helper'

describe SessionTime do
  its "title is empty if start or end time are undefined" do
    SessionTime.new.title.should eq('')
  end

  its "title contains start and end time" do
    Factory(:session_time).title.should eq('Tuesday from 12:30 to 01:30 PM')
  end
end
