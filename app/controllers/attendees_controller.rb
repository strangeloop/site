class AttendeesController < ApplicationController
  before_filter :authenticate_attendee_cred!
  respond_to :html, :ics, :only => :show

  expose(:attendee)

  expose(:current_year_attendees) {
    Attendee.current_year.paginate :page => params[:page], :per_page => 60
  }

  expose(:schedule_sessions) { attendee.sorted_interested_sessions }

  def show
    respond_to do |format|
      format.html
      format.ics { render :layout => false, :text => attendee.session_calendar.export }
    end
  end

  def update
    begin
      current_attendee.update_attributes! params[:attendee]
      flash[:notice] = 'Update successful'
    rescue StandardError => issue
      flash[:alert] = "The update failed#{issue.message.gsub('Validation failed', '')}"
    end
    redirect_to current_attendee
  end
end
