require 'spec_helper'

describe Service do
  [:provider, :uid, :uname].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :attendee_cred}

  it {should have_db_column(:uemail).of_type(:string)}

  let(:google_omniauth) {{'uid' => 'Henry',
    'provider' => 'google',
    'user_info' =>
      {'email' => 'henry@chinaski.com',
        'name' => 'Henry Chinaski'}}}

  it "should create a google service" do
    svc = Service.google_service google_omniauth
    svc.uemail.should == 'henry@chinaski.com'
    svc.uname.should == 'Henry Chinaski'
    svc.uid.should == 'Henry'
    svc.provider.should == 'google'
  end

end
