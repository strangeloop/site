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

  context "export action" do
    it "exports proposals to CSV" do
      Proposal.stub(:pending_to_csv).with().and_return('a, b, c')
      get "export", :format => "csv"
      response.body.should == 'a, b, c'
    end
  end
end
