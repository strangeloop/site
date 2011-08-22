require 'spec_helper'

describe ServicesController do

  let(:controller){ServicesController.new}

  def validate_service(service, provider)
    service.uemail.should == 'foo@bar.com'
    service.uid.should == '1234'
    service.uname.should == 'Foo'
    service.provider.should == provider
  end


  it "should map the google request to a service object" do
    service = controller.service_info('google',
                                      {'uid' => '1234',
                                        'provider' => 'Google',
                                        'user_info' =>
                                        {'email' => 'foo@bar.com',
                                          'name' => 'Foo'}})
    validate_service service, 'Google'
  end

  it "should map the facebook request to a service object" do
    service = controller.service_info('facebook',
                                      {'provider' => 'Facebook',
                                        'extra' =>
                                        {'user_hash' =>
                                          {'email' => 'foo@bar.com',
                                            'name' => 'Foo',
                                            'id' => '1234'}}})

    validate_service service, 'Facebook'
  end

  it "should map the github request to a service object" do
    service = controller.service_info('github',
                                      {'provider' => 'Github',
                                        'extra' => {'user_hash' => {'id' => '1234', 'name' => 'Foo'}},
                                        'user_info' =>
                                          {'email' => 'foo@bar.com'}})

    validate_service service, 'Github'
  end

  it "should map the twitter request to a service object" do
    service = controller.service_info('twitter',
                                      {'provider' => 'Twitter',
                                        'uid' => '1234',
                                        'user_info' =>
                                        {'name' => 'Foo'}})
    service.uid.should == '1234'
    service.uname.should == 'Foo'
    service.provider.should == 'Twitter'
    service.uemail.should == ''
  end

  let(:attendee){Factory(:attendee)}
  let(:service) do
    s = Service.new
    s.uemail = "julian_english@prodigy.net"
    s.uid = '1234'
    s.provider = 'Google'
    s.uname = 'Julian English'
    s
  end
  
  it "should create user record for attendees with a token" do
    attendee.attendee_cred.delete
    controller.create_user(Attendee.find(attendee.id), service)
    
    at = Attendee.find(attendee.id)
    user = at.attendee_cred
    svc = user.services.first

    at.acct_activation_token.should be_nil
    at.token_created_at.should be_nil
    
    user.id.should_not be_nil
    user.email.should == attendee.email
    
    service.uemail.should == svc.uemail
    service.uname.should == svc.uname
    service.provider.should == svc.provider
    service.uid.should == svc.uid
  end

  it "should find existing google user" do
    s = Service.new
    s.provider = 'Google'

    attendee.acct_activation_token = 'unique-id'
    attendee.save!
    authed_attendee = controller.attendee_from_auth(s, 'unique-id', nil)
    authed_attendee.should == attendee
  end

  it "should find existing twitter user" do
    attendee.twitter_id = 'foo'
    attendee.save!
    
    s = Service.new
    s.provider = 'Twitter'
    authed_attendee = controller.attendee_from_auth(s, nil, 'foo')
    
    attendee.should == authed_attendee
  end

  it "should find existing github user" do

    attendee.email = 'foo@bar.com'
    attendee.save!

    s = Service.new
    s.provider = 'Github'
    s.uemail = 'foo@bar.com'
    authed_attendee = controller.attendee_from_auth(s, nil, nil)
    attendee.should == authed_attendee
  end

end
