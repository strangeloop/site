class AttendeesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  expose(:attendee) do
    atndee =  Attendee.find_by_user_id(current_user.id) if current_user
    atndee ||= Attendee.find(params[:id])
  end

  expose(:current_year_attendees) { Attendee.current_year }

  def update
    attendee.update_attributes(params[:attendee])
  end

end
