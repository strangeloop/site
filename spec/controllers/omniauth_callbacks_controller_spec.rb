require 'spec_helper'

describe OmniauthCallbacksController do

  let(:attendee){Factory(:attendee)}
  let(:reg_attendee){Factory(:attendee_with_service)}

  def omniauth_callback
    Factory.create(:admin)
    request.env["devise.mapping"] = Devise.mappings[:attendee_cred]
  end

  def google_callback
    omniauth_callback
    @request.env['omniauth.auth'] = {'uid' => 'Henry',
        'provider' => 'google',
        'user_info' =>
        {'email' => 'henry@chinaski.com',
          'name' => 'Henry Chinaski'}}
  end

  context do
    before do
      google_callback
    end
    
    it "should log in an existing user" do
      get :google, {:token => reg_attendee.acct_activation_token}
      flash[:notice].should == "Successfully authenticated with Google"
      subject.current_attendee_cred.should == reg_attendee.attendee_cred
      subject.attendee_cred_signed_in?.should be_true
    end
    
    it "should register a new google user" do
      attendee.attendee_cred.services.should be_empty
      get :google, {:token => attendee.acct_activation_token}

      saved_attendee = Attendee.find(attendee.id)
      flash[:notice].should == "Successfully registered #{attendee.email} via Google"
      subject.current_attendee_cred.should == saved_attendee.attendee_cred
      subject.attendee_cred_signed_in?.should be_true
      saved_attendee.acct_activation_token.should be_nil
      saved_attendee.token_created_at.should be_nil
      saved_attendee.attendee_cred.services.size.should == 1
    end
  end

  def github_callback(uid)
    omniauth_callback
    @request.env['omniauth.auth'] = {'provider' => 'github',
      'extra' => {'user_hash' => {'id' => uid}},
      'user_info' =>
      {'email' => attendee.email,
        'name' => 'Henry Chinaski'}}
  end


  let!(:gh_attendee){Factory(:github_attendee)}
  context do
    before do
      github_callback( 'Henry')
    end

    it "should log in an existing user" do
      get :github
      flash[:notice].should == "Successfully authenticated with Github"
      subject.current_attendee_cred.should == gh_attendee.attendee_cred
      subject.attendee_cred_signed_in?.should be_true
    end
    
  end

  context do
    before do
      github_callback( 'Henry-uid')
    end

    it "should register a new google user" do
      attendee.attendee_cred.services.should be_empty
      get :github
      saved_attendee = Attendee.find(attendee.id)
      flash[:notice].should == "Successfully registered #{attendee.email} via Github"
      subject.current_attendee_cred.should == saved_attendee.attendee_cred
      subject.attendee_cred_signed_in?.should be_true
      saved_attendee.acct_activation_token.should be_nil
      saved_attendee.token_created_at.should be_nil
      saved_attendee.attendee_cred.services.size.should == 1
    end
  end
end
