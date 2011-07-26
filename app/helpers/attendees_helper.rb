module AttendeesHelper
  def full_name(user)
    attendee = Attendee.find_by_user_id(user.id)
    return '' unless attendee
    attendee.full_name
  end
end
