require 'spec_helper'

describe AttendeesController do
  let(:attendee) { Factory(:attendee) }
  let(:registered_attendee) { Factory(:registered_attendee) }

  before(:each) do
    #Must create an attendee record to prevent refinery
    #from redirecting to welcome page
    Factory.create(:admin)
    @request.env['devise.mapping'] = :admin
    sign_in registered_attendee.attendee_cred
  end

  context ".show" do
    it "exposes a specific attendee" do
      get :show, :id => attendee.id
      controller.attendee.should eq(attendee)
    end

    it "exports the session calendar for a specific attendee" do
      get :show, :id => attendee.id, :format => :ics
      response.body.should eq(attendee.session_calendar.export)
    end
  end

  context ".update" do
    it "writes a flash error when an attendee required attribute is updated to nil" do
      post :update, :attendee => {:email => nil}
      flash[:alert].should eq("The update failed: Email can't be blank")
    end

    it "writes a flash notice on successful update" do
      post :update, :attendee => {:email => 'me@you.com'}
      flash[:notice].should eq('Update successful')
    end
  end

  context ".current_year_attendees" do
    before(:each) do
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

  it "#edit exposes a specific attendee for #edit" do
    get :edit
    controller.current_attendee.should eq(registered_attendee)
  end
end
