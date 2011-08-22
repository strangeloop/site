class AttendeesController < ApplicationController
  before_filter :authenticate_attendee_cred!

  expose(:attendee)

  expose(:current_year_attendees) {
    Attendee.registered.current_year.paginate :page => params[:page], :per_page => 60
  }

  expose(:sessions_for_schedule) { attendee.sorted_interested_sessions }

  def update
    current_attendee.update_attributes params[:attendee]
    redirect_to current_attendee
  end

end
