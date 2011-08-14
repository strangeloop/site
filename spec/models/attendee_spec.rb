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

describe Attendee do

  [:first_name, :last_name, :email, :reg_id].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :user}

  [:middle_name, :city, :state, :country, :email,
   :twitter_id, :blog_url, :company].each do |field|
    it {should have_db_column(field).of_type(:string)}
  end

  it {should have_db_column(:token_created_at).of_type(:datetime)}

  let(:um){Factory(:attendee)}
  
  it "should decrypt encrypted strings" do
    encrypted_txt = um.activation_token
    encrypted_txt.should_not ==  format("julian_english@prodigy.net|%s|2011-07-04 11:19:00 UTC",um.acct_activation_token)
    decrypted_txt = Attendee.decrypt_token encrypted_txt
    decrypted_txt.should ==  ["julian_english@prodigy.net",um.acct_activation_token,"2011-07-04 11:19:00 UTC"]
  end

  let(:attendee){Factory(:attendee)}

  it "should pass an auth check for a known users" do
    token = attendee.activation_token
    Attendee.check_token(token).should be_true
  end

  it "should fail on incorrect uids" do
    attendee.acct_activation_token = "foo"
    token = attendee.activation_token
    Attendee.check_token(token).should be_false
  end

  it "should fail on incorrect date" do
    token = attendee.activation_token
    attendee.token_created_at = DateTime.parse('1985-10-25')
    attendee.save!
    Attendee.check_token(token).should be_false
  end

  it "should fail on incorrect email" do
    attendee.email = "something@different.net"
    token = attendee.activation_token
    Attendee.check_token(token).should be_false
  end
  
  let(:um){Factory(:attendee)}

  it "should generate an activation token upon save" do
    activation_token = um.acct_activation_token
    um.save!
    activation_token.should != um.acct_activation_token
  end

  it "should generate an activation url with a token" do
    attendee.activation_url.should == format("https://localhost:3000/account_activation?token=%s", attendee.activation_token)
  end

end

