require 'spec_helper'

describe "routes for archive" do
  it "routes /archive/2010 to conference_sessions controller index action" do
    { :get => '/archive/2010' }.should route_to(:controller => 'conference_sessions', 
                                                :action => 'index',
                                                :year => '2010')
  end
end
