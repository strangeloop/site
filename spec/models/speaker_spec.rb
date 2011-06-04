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

describe Speaker do
  [:first_name, :last_name, :email, :bio].each do |field| 
    it {should validate_presence_of field}
  end

  it {should allow_value("MO").for(:state)}
  it {should allow_value("IL").for(:state)}
  it {should allow_value("CA").for(:state)}

  it {should allow_value("US").for(:country)}
  it {should allow_value("CA").for(:country)}

  let!(:model){Factory(:speaker)}

  it "should auto add the current year as conf_year" do
    model.conf_year.should == Time.now.year
    #Commented out because it makes the tests run 300% slower
    #TODO: Figure out a way to fix this - Also commented out is a
    #factory for Image
    #model.image.image.data.should == DatastoreImage.find_by_uid(model.image.image_uid).image
  end

  it {should allow_value("123-456-7891").for(:phone)}
  it {should allow_value("1234567891").for(:phone)}

  it{ should_not allow_value("x" * 801).for(:bio)}

  it "strips @ symbols from twitter_id" do
    Speaker.new(:twitter_id => '@foo').twitter_id.should == 'foo'
  end

  it "string value should equal first name and last name" do
  	speaker = Speaker.new
  	speaker.first_name = "Hillary"
  	speaker.last_name = "Mason"
  	speaker.to_s.should == speaker.first_name + " " + speaker.last_name
  end
end
