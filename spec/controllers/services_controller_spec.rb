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
end
