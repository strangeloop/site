require 'spec_helper'

describe Sponsorship do

  context "validations" do
   [:year, :level, :sponsor].each do |field|
     it {should validate_presence_of field}
   end 

   [:sponsor, :contact].each do |relation|
     it {should belong_to relation}
   end
    
  end

end
