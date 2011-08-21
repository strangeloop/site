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

describe "routes for archive" do
  it "routes /archive/2010 to conference_sessions controller index action" do
    { :get => '/archive/2010' }.should route_to(:controller => 'conference_sessions',
                                                :action => 'index',
                                                :year => '2010')
  end
end

describe "routes for export" do
  it "routes export/2010.csv to admin/conference_sessions controller export action" do
    { :get => '/refinery/conference_sessions/export/2010.csv' }.should route_to(:controller => 'admin/conference_sessions',
                                                   :action => 'export',
                                                   :year => '2010',
                                                   :format => 'csv')
  end
end
