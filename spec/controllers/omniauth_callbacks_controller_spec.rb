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

  def assert_registered_attendee(attendee, provider_s)
    attendee.reload

    flash[:notice].should == "Successfully registered #{attendee.email} via #{provider_s}"
    subject.current_attendee_cred.should == attendee.attendee_cred
    subject.attendee_cred_signed_in?.should be_true
    attendee.acct_activation_token.should be_nil
    attendee.token_created_at.should be_nil
    attendee.attendee_cred.services.size.should == 1
  end

  def assert_failed_registration(attendee, error_regex)
    attendee.reload

    subject.current_attendee_cred.should == attendee.attendee_cred
    flash[:error].should =~ error_regex
    subject.attendee_cred_signed_in?.should be_false
    attendee.acct_activation_token.should_not be_nil
    attendee.token_created_at.should_not be_nil
    attendee.attendee_cred.should be_nil
  end

  def assert_logged_in(attendee, provider)
    flash[:notice].should == "Successfully authenticated with #{provider}"
    subject.current_attendee_cred.should == attendee.attendee_cred
    subject.attendee_cred_signed_in?.should be_true
  end
  
  context do
    before do
      google_callback
    end

    it "should log in an existing user" do
      get :google, {:token => reg_attendee.acct_activation_token}
      assert_logged_in(reg_attendee, "Google")
    end

    it "should register a new google user" do
      attendee.attendee_cred.should be_nil
      get :google, {:token => attendee.acct_activation_token}
      assert_registered_attendee(attendee, "Google")
    end
  end

  def github_callback(uid, email=attendee.email)
    omniauth_callback
    @request.env['omniauth.auth'] = {'provider' => 'github',
      'extra' => {'user_hash' => {'id' => uid}},
      'user_info' =>
      {'email' => email,
        'name' => 'Henry Chinaski'}}
  end


  let!(:gh_attendee){Factory(:github_attendee)}
  context do
    before do
      github_callback('Henry')
    end

    it "should log in an existing user" do
      get :github
      assert_logged_in(gh_attendee, "Github")
    end

  end

  context do
    before do
      github_callback('Henry-uid')
    end

    it "should register a new github user" do
      attendee.attendee_cred.should be_nil
      get :github
      assert_registered_attendee(attendee, "Github")
    end
  end

  context do
    before do
      github_callback('Henry-uid', 'differentemail@chinaski.com')
    end

    it "should not register a github user with wrong email" do
      attendee.attendee_cred.should be_nil
      get :github
      assert_failed_registration(attendee,  /doesn't match the email that you provided when you registered/)
    end
  end

  def twitter_callback(uid, twitter_id)
    omniauth_callback
    @request.env['omniauth.auth'] = {'provider' => 'twitter',
      'uid' => uid,
      'user_info' =>
      {'name' => 'Henry Chinaski',
        'screen_name' => twitter_id}}
  end

  let!(:tw_attendee){Factory(:twitter_attendee)}
  context do
    before do
      twitter_callback('Henry', attendee.twitter_id)
    end

    it "should log in an existing twitter user" do
      get :twitter
      assert_logged_in(tw_attendee, "Twitter")
    end

  end

  context do
    before do
      twitter_callback( 'Henry-uid', attendee.twitter_id)
    end

    it "should register a new twitter user" do
      attendee.attendee_cred.should be_nil
      get :twitter
      assert_registered_attendee(attendee, "Twitter")
    end
  end

  context do
    before do
      twitter_callback( 'Henry-uid', 'somethingrandom')
    end

    it "should not register when the twitter ids don't match" do
      attendee.attendee_cred.should be_nil
      get :twitter
      assert_failed_registration(attendee, /^Sorry but we could not/)
    end
  end
end
