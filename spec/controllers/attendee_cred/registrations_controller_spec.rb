require 'spec_helper'

describe AttendeeCred::RegistrationsController do
  let(:attendee) { Factory(:attendee) }

  context ".create" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:attendee_cred]
    end

    it "an attendee_cred for the attendee" do
      pending
      post :create, :attendee_cred => {:password => 'foobarbaz',
        :password_confirmation => 'foobarbaz',
        :email => attendee.email},
        :token => {:text => attendee.activation_token}
      AttendeeCred.first.attendee.should eq(attendee)
    end

    it "writes flash error and redirects back to registration page on error" do
      post :create, :attendee_cred => {:password => 'foo',
        :password_confirmation => 'foo',
        :email => attendee.email},
        :token => {:text => attendee.activation_token}
      flash[:error].should eq('Registration failed, please try again: password is too short (minimum is 4 characters)')
      response.should redirect_to(activation_path(:token => attendee.activation_token))
    end
  end
end
