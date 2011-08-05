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
  @@activation_url_prefix = YAML::load_file('config/activation.yml')["activation_url_prefix"]
  
  belongs_to :user
  [:first_name, :last_name, :email, :reg_id].each do |field|
    validates field, :presence => true
  end

  before_create {|um| um.acct_activation_token= UUIDTools::UUID.random_create.to_s}

  def remove_newlines(s)
    s.gsub(/\n/,'')
  end

  def encrypt_str(s)
    Crypto.encrypt(@@activation_key, s)
  end

  def encode(s)
    remove_newlines(Base64.encode64(s))
  end
  
  def activation_token
    encode(encrypt_str([email,acct_activation_token,token_created_at].join("|")))
  end

  def activation_url
    format("%s?token=%s", @@activation_url_prefix, activation_token)
  end
  
  def self.decrypt_token (cipher_text)
    Crypto.decrypt(@@activation_key, Base64.decode64(cipher_text)).split("|")
  end

  def self.check_token (cipher_text)
    token = decrypt_token(cipher_text)
    date = DateTime.parse(token[2])
    attendee =  Attendee.where("acct_activation_token = ?", token[1]).first
    if attendee && attendee.token_created_at == date && attendee.email == token[0]
      attendee
    else
      false
    end
    
  end
end
