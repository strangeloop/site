require 'spec_helper'

describe "routes for export" do
  it "routes export/submitted.csv to admin/proposals controller export action" do
    { :get => '/refinery/proposals/export/pending.csv' }.should route_to(:controller => 'admin/proposals',
                                                   :action => 'export',
                                                   :format => 'csv')
  end
end