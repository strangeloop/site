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
