module AttendeesHelper
  def full_name(user)
    Attendee.find_by_attendee_cred_id(user.id).try(:full_name) || ''
  end

  def schedule_partial(attendee)
    attendee.conference_sessions.empty? ? no_schedule(attendee) : 'populated_schedule'
  end

  def is_current_attendee?(attendee)
    current_attendee_cred == attendee.attendee_cred
  end

  def company_link(attendee)
    return '' unless attendee.company
    return attendee.company unless attendee.company_url
    link_to attendee.company, attendee.company_url
  end

  private
  def no_schedule(attendee)
    is_current_user?(attendee) ? 'no_schedule' : 'no_schedule_visitor'
  end

end
