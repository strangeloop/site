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

class Attendee < ActiveRecord::Base
  
  @@activation_key = YAML::load_file('config/activation.yml')["activation_key"]
  
  belongs_to :user
  [:first_name, :last_name, :email, :reg_id, :reg_status].each do |field|
    validates field, :presence => true
  end

  before_create {|um| um.reg_uid= UUIDTools::UUID.random_create.to_s}

  def activation_token
    Crypto.encrypt(@@activation_key, [email,reg_uid,reg_date].join(","))
  end

  def self.decrypt_token (cipher_text)
    Crypto.decrypt(@@activation_key, cipher_text)
  end

end
