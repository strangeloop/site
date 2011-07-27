class AttendeesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :current]

  expose(:attendee) do
    atndee =  Attendee.find_by_user_id(current_user.id) if current_user
    atndee ||= Attendee.find(params[:id]) if params[:id]
    atndee
  end

  expose(:current_year_attendees) { Attendee.current_year.paginate :page => params[:page] }

  def update
    attendee.update_attributes(params[:attendee])
  end

  def current
    render :json => { :username      => attendee.try(:full_name),
                      :attendee_path => attendee_path,
                      :login_path    => new_user_session_path,
                      :logout_path   => destroy_user_session_path }
  end

end
