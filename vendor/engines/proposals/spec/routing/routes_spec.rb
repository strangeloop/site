require 'spec_helper'

describe "routes for export" do
  it "routes export/submitted.csv to admin/proposals controller export action" do
    { :get => '/refinery/proposals/export/submitted.csv' }.should route_to(:controller => 'admin/proposals',
                                                   :action => 'export',
                                                   :status => 'submitted',
                                                   :format => 'csv')
  end
end
