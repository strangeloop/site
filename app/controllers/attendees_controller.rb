class AttendeesController < ApplicationController
  respond_to :html, :ics, :only => :show

  before_filter :authenticate_user!

  expose(:attendee)

  expose(:current_year_attendees) {
    Attendee.registered.current_year.paginate :page => params[:page], :per_page => 60
  }

  expose(:sessions_for_schedule) { attendee.sorted_interested_sessions }

  def show
    respond_to do |format|
      format.html
      format.ics { render :layout => false, :text => attendee.session_calendar.export }
    end
  end

  def update
    current_attendee.update_attributes params[:attendee]
    redirect_to current_attendee
  end

end
