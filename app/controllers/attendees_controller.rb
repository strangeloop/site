class AttendeesController < ApplicationController
  before_filter :authenticate_user!

  expose(:attendee)

  expose(:current_year_attendees) { Attendee.current_year.paginate :page => params[:page] }

  expose(:sessions_for_schedule) { attendee.sorted_interested_sessions }

  def update
    current_attendee.update_attributes params[:attendee]
    redirect_to current_attendee
  end

end
