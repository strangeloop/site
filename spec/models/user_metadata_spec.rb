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

describe UserMetadata do

  [:first_name, :last_name, :email, :reg_id, :reg_status].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :user}

  [:middle_name, :address_1, :address_2, :gender, :city,
   :state, :country, :postal_code, :home_phone, :work_phone,
   :cell_phone, :email, :company_name, :twitter_id, :blog_url,
   :company].each do |field|
    it {should have_db_column(field).of_type(:string)}
  end

  it {should have_db_column(:reg_date).of_type(:datetime)}

  let(:july4){DateTime.parse('Thursday, July 4, 2011 11:19 AM')}
  let(:um){UserMetadata.new :email => "foo@bar.com", :reg_uid => "big uid here", :reg_date => july4}

  # it "generates a string suitable for encryption" do
  #   um.reg_s.should == "foo@bar.com,big uid here,2011-07-04 11:19:00 UTC"
  # end

  it "should decrypt encrypted strings" do
    encrypted_txt = um.activation_token
    encrypted_txt.should_not ==  "foo@bar.com,big uid here,2011-07-04 11:19:00 UTC"
    decrypted_txt = UserMetadata.decrypt_token encrypted_txt
    decrypted_txt.should ==  "foo@bar.com,big uid here,2011-07-04 11:19:00 UTC"
  end
end

