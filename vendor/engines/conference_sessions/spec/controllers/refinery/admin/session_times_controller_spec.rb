require 'spec_helper'
require_relative '../../../../app/controllers/refinery/admin/session_times_controller'

describe Refinery::Admin::SessionTimesController do
  it "sorts by start time ascending" do
    described_class.should_receive(:crudify).with(:session_time, {:order => 'start_time ASC'})
    load(File.join(File.dirname(__FILE__),'..','..','..','..','app', 'controllers', 'refinery', 'admin', 'session_times_controller.rb'))
  end

end
