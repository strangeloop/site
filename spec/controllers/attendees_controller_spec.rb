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
    controller.current_year_attendees.should eq([attendee])
  end

  it "paginates on #index" do
    attendee
    get :index, :page => 1
    controller.current_year_attendees.should eq([attendee])
  end

  it "return an empty list on a page request past the total on #index" do
    attendee
    get :index, :page => 2
    controller.current_year_attendees.should be_empty
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
      controller.attendee.should eq(attendee)
    end

    it "#toggle passes session_id to an attendee for update" do
      controller.attendee.should_receive(:toggle_session).with(1).and_return(true)
      put :toggle_session, :sessionid => 1
      ActiveSupport::JSON.decode(response.body).should eq(ActiveSupport::JSON.decode({:willAttend => true}.to_json))
    end
  end
end
