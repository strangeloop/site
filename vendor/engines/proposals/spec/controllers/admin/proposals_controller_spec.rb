require 'spec_helper'

describe Admin::ProposalsController do
  context 'role checking' do
    login_admin

    it "ensures the current user has the reviewer role before allowing rating" do
      post :rate, :id => 1, :format => 'js'
      assigns[:proposal].should be_nil
      response.should redirect_to(root_path)
    end

    it "redirects if non-organizers try to call export" do
      get :export, :format => 'csv'
      response.should redirect_to(root_path)
    end
  end

  context "export action" do
    login_organizer

    it "exports proposals to CSV" do
      Proposal.stub(:pending_to_csv).and_return('a, b, c')
      get :export, :format => 'csv'
      response.body.should == 'a, b, c'
    end
  end
end
