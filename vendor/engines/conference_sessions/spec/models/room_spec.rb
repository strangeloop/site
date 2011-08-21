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

describe Room do
  let(:room) { Factory(:room) }

  it "sets conf_year automatically" do
    Room.create(:name => 'f', :capacity => 2).conf_year.should == Time.now.year
  end

  it "has unique names across conf_years" do
    room.should be_valid
    Factory(:room, :conf_year => Time.now.year - 1).should be_valid
    Factory.build(:room).should_not be_valid
  end

  it "requires a capacity value" do
    Room.new(:name => 'foo').should_not be_valid
  end

  it "requires a room name" do
    Room.new(:capacity => 2).should_not be_valid
  end

  context "#current_year" do
    it "only includes rooms from this year" do
      current_year_room = Factory(:room)
      Factory(:room, :conf_year => 2010)
      Room.current_year.should == [current_year_room]
    end
  end
end
