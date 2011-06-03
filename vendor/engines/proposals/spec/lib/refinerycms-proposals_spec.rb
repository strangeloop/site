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

describe Refinery::Proposals::Engine do
  describe "Plugin#title" do
    let(:title) { 
      Refinery::Plugins.registered.find{|p| "proposals" == p.name}.title
    }

    context "no pending proposals" do
      before (:each) do
        Proposal.stub(:pending_count).and_return(0)
      end

      it "responds to title" do
        title.should_not be_nil
      end

      it "have no numeric suffix by default" do
        title.should_not =~ /\w\s\(/
      end
    end

    it "show a numeric suffix if there are proposals in a pending state" do
      Proposal.stub(:pending_count).and_return(2)
      title.should =~ /\w\s\(2\)/
    end
  end
end
