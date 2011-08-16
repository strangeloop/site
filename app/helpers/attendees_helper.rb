module AttendeesHelper
  def full_name(user)
    Attendee.find_by_user_id(user.id).try(:full_name) || ''
  end

  def schedule_partial(attendee)
    attendee.conference_sessions.empty? ? 'no_schedule' : 'populated_schedule'
  end

  def is_current_user?(attendee)
    current_user == attendee.user
  end

  def company_link(attendee)
    return '' unless attendee.company
    return attendee.company unless attendee.company_url
    link_to attendee.company, attendee.company_url
  end

end
