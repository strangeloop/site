require 'spec_helper'

describe UserMetadata do

  [:first_name, :last_name, :email, :reg_id, :reg_status].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :user}

  [:middle_name, :address_1, :address_2, :gender, :city,
   :region, :country, :postal_code, :home_phone, :work_phone,
   :cell_phone, :email, :company_name, :twitter_id, :blog_url].each do |field|
    it {should have_db_column(field).of_type(:string)}
  end

end

