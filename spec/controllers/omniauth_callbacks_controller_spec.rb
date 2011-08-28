require 'spec_helper'

describe OmniauthCallbacksController do

  let(:attendee){Factory(:attendee_with_service)}
  context do
    before do
       Factory.create(:admin)

      request.env["devise.mapping"] = Devise.mappings[:attendee_cred]

      @request.env['omniauth.auth'] = {'uid' => 'Henry',
        'provider' => 'google',
        'user_info' =>
        {'email' => 'henry@chinaski.com',
          'name' => 'Henry Chinaski'}}

    end
    
    it "should log in an existing user" do
      get :google, {:token => attendee.acct_activation_token}
      flash[:notice].should == "Successfully authenticated with Google"
    end
  end
end
