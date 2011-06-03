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

describe RegOnlineController do

  def post_params
    {"FirstName" => "Jeffrey",
      "LastName" => "Lebowski",
      "Email" => "thedude@lebowski.org",
      "RegisterId" => "1234",
      "Address1" => "123 4th Street",
      "Gender" => "M",
      "City" => "Los Angelos",
      "Region" => "California",
      "Country" => "US",
      "Twitter_x0020_Username" => "@thedude"}
  end
 
    
  before(:each) do
    @controller = RegOnlineController.new
    @stub_regonline = RegOnline.new :username => "foo", :password => "bar"
    @um = UserMetadata.new
    @params_map = post_params
  end

  it "should not save users that have not be validated" do
    @stub_regonline.stub!(:get_custom_user_info).and_return(false)
    @um.should_not_receive(:save)
    @controller.create_user_meta(@stub_regonline, @params_map, @um).should be_false
  end
  it "should save user meta for a validated user" do
    @stub_regonline.should_receive(:get_custom_user_info).and_return(true)
    @controller.create_user_meta(@stub_regonline, @params_map, @um).should be_true

    db_um = UserMetadata.find(@um.id)
    db_um.first_name.should == "Jeffrey"
    db_um.last_name.should == "Lebowski"
    db_um.reg_id.should == "1234"
    db_um.reg_id.should == "1234"
  end
end
