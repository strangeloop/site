module ConferenceSessionsHelper
  def room_names_for(session_day, formats)
    ConferenceSession.rooms_by_day_and_formats(session_day.to_date, formats).map(&:room).map(&:name).uniq
  end

  def spacers_needed_count(rooms, session, index)
    (rooms.index(room_for(session).to_s) || index) - index
  end
end
