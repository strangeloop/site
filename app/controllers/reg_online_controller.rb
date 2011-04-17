
class RegOnlineController < ApplicationController

  skip_before_filter :verify_authenticity_token

  @@form_mapping =
    {"FirstName" => :first_name,
    "LastName" => :last_name,
    "Email" => :email,
    "RegisterId" => :reg_id,
    "Address1" => :address_1,
    "Address2" => :address_2,
    "Gender" => :gender,
    "City" => :city,
    "Region" => :region,
    "Country" => :country,
    "Postcode" => :postal_code,
    "Phone" => :work_phone,
    "HomePhone" => :home_phone,
    "Mobile" => :cell_phone}  

  def create
    debugger
    # Fields TODO - dob, middle_name?, twitter_id, blog_url,
    # company_name
    um = UserMetadata.new

    @@form_mapping.each do |form_name, model_name|
      um[model_name] = params[form_name]
    end
    um[:reg_status]="Confirmed"
    um.save
    render :nothing => true
  end
end

