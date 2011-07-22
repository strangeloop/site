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

  let(:july4){DateTime.parse('Thursday, July 4, 2011 11:19 AM')}
  let(:um){Attendee.new :email => "foo@bar.com", :acct_activation_token => "big uid here", :token_created_at => july4}

  it "should decrypt encrypted strings" do
    encrypted_txt = um.activation_token
    encrypted_txt.should_not ==  "foo@bar.com|big uid here|2011-07-04 11:19:00 UTC"
    decrypted_txt = Attendee.decrypt_token encrypted_txt
    decrypted_txt.should ==  ["foo@bar.com","big uid here","2011-07-04 11:19:00 UTC"]
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
    attendee.token_created_at = DateTime.now
    token = attendee.activation_token
    Attendee.check_token(token).should be_false
  end

  it "should fail on incorrect email" do
    attendee.email = "something@different.net"
    token = attendee.activation_token
    Attendee.check_token(token).should be_false
  end

  it "retrieves attendees by the latest year" do
    previous_conf_attendee = Factory(:attendee, :conf_year => 2010)
    attendee
    Attendee.current_year.should eq([attendee])
  end

  it "joins all names in #full_name" do
    Attendee.new(:first_name => 'Mario',
                 :middle_name => 'Enrique',
                 :last_name => 'Aquino').full_name.should eq('Mario Enrique Aquino')
  end
end

