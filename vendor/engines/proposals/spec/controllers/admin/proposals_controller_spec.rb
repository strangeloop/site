require 'spec_helper'

describe Admin::ProposalsController do
  login_reviewer

  context "#rate" do
    it "ensures the current user has the reviewer role" do
      controller.stub(:current_user).and_return(Factory(:admin))
      post :rate, :id => 1, :format => 'js'
      assigns[:proposal].should be_nil
    end
  end
end
