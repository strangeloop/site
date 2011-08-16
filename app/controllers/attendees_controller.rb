class AttendeesController < ApplicationController
  before_filter :authenticate_user!

  expose(:attendee)

  expose(:current_attendee) { Attendee.find_by_user_id(current_user.id) if current_user }

  expose(:current_year_attendees) { Attendee.current_year.paginate :page => params[:page] }

  expose(:sessions_for_schedule) { attendee.sorted_interested_sessions }

  def update
    current_attendee.update_attributes params[:attendee]
    redirect_to current_attendee
  end

  def current
    render :json => { :username      => current_attendee.try(:full_name),
                      :attendee_path => attendee_path(current_attendee),
                      :login_path    => new_user_session_path,
                      :logout_path   => destroy_user_session_path }
  end

end
