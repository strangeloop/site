require 'spec_helper'

describe RegOnlineController do

  def post_params
    {"FirstName" => "Jeffrey",
      "LastName" => "Lebowski",
      "Email" => "thedude@lebowski.org",
      "RegisterId" => "1234",
      "Address1" => "123 4th Street",
      "Gender" => "M",
      "City" => "Los Angelos",
      "Region" => "California",
      "Country" => "US",
      "Twitter_x0020_Username" => "@thedude"}
  end
 
    
  before(:each) do
    @controller = RegOnlineController.new
    @stub_regonline = Object.new
    @um = UserMetadata.new
    @params_map = post_params
  end

  #Not able to get rspec tests to call controllers properly, leaving
  #this out.  Tested via command line with the below command:
  # curl -d "FirstName=Clem&LastName=Esterbill&Email=foo@bar.com&RegisterId=1234" 
  # http://localhost:4000/reg_online/new.html
  it "should not save users that have not be validated" do
    @stub_regonline.stub!(:get_custom_user_info).and_return(false)
    @um.should_not_receive(:save)
    @controller.create_user_meta(@stub_regonline, @params_map, @um).should be_false
  end
  it "should save user meta for a validated user" do
    @stub_regonline.should_receive(:get_custom_user_info).and_return(true)
    @controller.create_user_meta(@stub_regonline, @params_map, @um).should be_true

    db_um = UserMetadata.find(@um.id)
    db_um.first_name.should == "Jeffrey"
    db_um.last_name.should == "Lebowski"
    db_um.reg_id.should == "1234"
    db_um.reg_id.should == "1234"
  end
end
