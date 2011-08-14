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
    #below are post params from a test callback (issued by regonline)
    {"RegisterId"=>"34063176",
      "DOB"=>"",
      "Gender"=>"NotSet",
      "EmergencyContactPhone"=>"",
      "City"=>"Ballwin",
      "ProxyPhone"=>"",
      "Mobile"=>"",
      "EventId"=>"959942",
      "LastName"=>"Test",
      "action"=>"create",
      "TotalCharge"=>"0.0000",
      "MiddleName"=>"",
      "Country"=>"United States",
      "FirstName"=>"Alex",
      "Phone"=>"",
      "ProxyEmail"=>"",
      "ProxyName"=>"",
      "WorkExtension"=>"",
      "JobTitle"=>"",
      "CCEmail"=>"",
      "EmergencyContactName"=>"",
      "Postcode"=>"63021",
      "PhoneExtension"=>"",
      "HomePhone"=>"",
      "te"=>"R1dEUWtLcGs4NzBwcEc5NW9FZjB6TTNVSTdsVVpSQVcwWmpqSmlrMTdEND0=",
      "TotalOtherFees"=>"0",
      "BadgeName"=>"",
      "Fax"=>"",
      "Company"=>"Strange Loop",
      "controller"=>"reg_online",
      "Email"=>"alex test@thestrangeloop.com",
      "State"=>"MO",
      "Prefix"=>"",
      "TotalAgendaFees"=>"0.00",
      "Address1"=>"123 ABC",
      "WorkPhone"=>"",
      "Suffix"=>"",
      "Address2"=>""}
  end
 
    
  before(:each) do
    @controller = RegOnlineController.new
    @stub_regonline = RegOnline.new :username => "foo", :password => "bar"
    @um = Attendee.new
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

    db_um = Attendee.find(@um.id)
    db_um.reg_id.should == "34063176"
    db_um.first_name.should == "Alex"
    db_um.last_name.should == "Test"
    db_um.email.should == "alex test@thestrangeloop.com"
    db_um.city.should == "Ballwin"
    db_um.country.should == "United States"
    db_um.company.should == "Strange Loop"
    db_um.state.should == "MO"
    
  end
end
