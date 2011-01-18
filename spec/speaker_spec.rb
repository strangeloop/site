require 'spec_helper'

describe Speaker do
  [:first_name, :last_name, :email, :bio].each do |field| 
    it {should validate_presence_of field}
  end

  Carmen::state_codes.each do |field|
    it {should allow_value(field).for(:state)}
  end
  
end
