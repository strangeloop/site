class AttendeesController < ApplicationController
  before_filter :authenticate_attendee_cred!
  respond_to :html, :ics, :only => :show

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
    begin
      result = current_attendee.update_attributes! params[:attendee]
    rescue StandardError => issue
      flash[:alert] = "The update failed#{issue.message.gsub('Validation failed', '')}"
    end
    redirect_to current_attendee
  end
end
