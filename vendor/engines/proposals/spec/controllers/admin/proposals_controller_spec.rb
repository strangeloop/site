#- Copyright 2011 Strange Loop LLC
#- 
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#- 
#-    http://www.apache.org/licenses/LICENSE-2.0
#- 
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and 
#- limitations under the License.
#- 



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
