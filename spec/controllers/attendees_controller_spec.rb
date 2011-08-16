require 'spec_helper'

describe AttendeesController do
  let(:attendee) { Factory(:attendee) }
  let(:registered_attendee) { Factory(:registered_attendee) }

  it "exposes a specific attendee for #show" do
    get :show, :id => attendee.id
    controller.attendee.should eq(attendee)
  end

  context ".current_year_attendees" do
    before(:each) do
      attendee
      registered_attendee
    end

    it "loads all attendees from current year for index action" do
      get :index
      controller.current_year_attendees.should eq([registered_attendee])
    end

    it "paginates on #index" do
      get :index, :page => 1
      controller.current_year_attendees.should eq([registered_attendee])
    end

    it "return an empty list on a page request past the total on #index" do
      get :index, :page => 2
      controller.current_year_attendees.should be_empty
    end

  end
  context "authenticated action" do
    before(:each) do
      #Must create an attendee record to prevent refinery
      #from redirecting to welcome page
      Factory.create(:admin)
      @request.env['devise.mapping'] = :admin
      sign_in attendee.user
    end

    it "#edit exposes a specific attendee for #edit" do
      get :edit
      controller.current_attendee.should eq(attendee)
    end
  end
end
