require 'spec_helper'

describe RegOnlineController do

  before(:each) do
    UserMetadata.stub!(:new).and_return(nil)
  end

  #Not able to get rspec tests to call controllers properly, leaving
  #this out.  Tested via command line with the below command:
  # curl -d "FirstName=Clem&LastName=Esterbill&Email=foo@bar.com&RegisterId=1234" 
  # http://localhost:4000/reg_online/new.html
  it "should save user meta" do
    pending
    post :new, :first_name => "Clem"

  end
end
