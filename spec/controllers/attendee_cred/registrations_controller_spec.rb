require 'spec_helper'

describe AttendeeCred::RegistrationsController do
  let(:attendee) { Factory(:attendee) }

  context ".create" do
    it "an attendee_cred for the attendee" do
      @request.env["devise.mapping"] = Devise.mappings[:attendee_cred]
      post :create, :attendee_cred => {:password => 'foobarbaz',
        :password_confirmation => 'foobarbaz',
        :email => attendee.email},
        :token => {:text => attendee.activation_token}
      AttendeeCred.first.attendee.should eq(attendee)
    end
  end
end
