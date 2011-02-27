require 'spec_helper'

describe Admin::ProposalsController do
  it "rates when the current user has the reviewer role" do
    user_mock = mock("user")
    user_mock.should_receive(:has_role?).with(:reviewer).and_return(false)
    controller.stub(:current_user).and_return(user_mock)
    post :rate
    assigns[:proposal].should be_nil
  end
end
