require 'spec_helper'

describe AttendeesController do
  let(:attendee) { Factory(:attendee) }

  it "exposes a specific attendee for #show" do
    get :show, :id => attendee.id
    controller.attendee.should eq(attendee)
  end

  it "loads all attendees from current year for index action" do
    attendee
    get :index
    controller.current_year_attendees.should == [attendee]
  end

  context "#edit" do
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in attendee.user
    end
    
    it "exposes a specific attendee for #edit" do
      get :edit
      controller.attendee.should eq(attendee)
    end
  end
end
