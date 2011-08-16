require 'spec_helper'

describe AccountActivationController do
  context ".new" do
    it "handles an invalid token" do
      get :new, :token => 'foo'
      controller.attendee.should be_nil
    end
  end
end
