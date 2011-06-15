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



class RegOnlineController < ApplicationController

  skip_before_filter :verify_authenticity_token

  @@form_mapping = {"FirstName" => :first_name=,
    "LastName" => :last_name=,
    "Email" => :email=,
    "RegisterId" => :reg_id=,
    "Address1" => :address_1=,
    "Address2" => :address_2=,
    "Gender" => :gender=,
    "City" => :city=,
    "Region" => :region=,
    "Country" => :country=,
    "Postcode" => :postal_code=,
    "Phone" => :work_phone=,
    "HomePhone" => :home_phone=,
    "Mobile" => :cell_phone=}

  @@custom_field_mapping = {"Twitter_x0020_Username" => :twitter_id}

  @@regonline_client = RegOnline.new( :username => 'Foo', :password => "Bar")

  def update_metadata (user_meta, field_set, data)
    field_set.each do |form_name, model_name|
      if data.has_key? form_name
        user_meta.send model_name, data[form_name]
      end
    end
    user_meta
  end

  def create_user_meta(regonline, params, um)
    # Fields TODO - dob, middle_name?, twitter_id, blog_url,
    # company_name
 client = Savon::Client.new  "https://www.regonline.com/activereports/RegOnline.asmx?wsdl"
    update_metadata(um, @@form_mapping, params)
    user_verified = regonline.get_custom_user_info(params["RegisterId"]) do |reg_hash|
      update_metadata(um, @@custom_field_mapping, params)
    end

    if user_verified
      um[:reg_status]="Confirmed"
      um.save
      puts "Just saved meta #{um.id}"
      true
    else
      logger.warn "Information for user with email #{um[:email]} and registration id I#{um[:reg_id]} cannot be verified"
      false
    end
  end
  
  def create
    created = create_user_meta @@regonline_client, params, UserMetadata.new
    render :nothing => true
  end
end

