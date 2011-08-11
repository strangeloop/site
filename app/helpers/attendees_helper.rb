module AttendeesHelper
  def full_name(user)
    Attendee.find_by_user_id(user.id).try(:full_name) || ''
  end

  def schedule_partial(attendee)
    attendee.conference_sessions.empty? ? 'no_schedule' : 'populated_schedule'
  end
end
