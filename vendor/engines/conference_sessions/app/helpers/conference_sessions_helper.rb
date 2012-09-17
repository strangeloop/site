module ConferenceSessionsHelper
  def room_names_for(session_day, formats)
    ConferenceSession.rooms_by_day_and_formats(session_day.to_date, formats).map(&:room).map(&:name).uniq
  end

  def session_time_period(session)
    if session.session_time.total_duration_minutes < 50
      content_tag :div, session.session_time.time_period, :class => 'session-time'
    else
      ''
    end
  end

  def row_height(room_sessions, room_names)
    room_sessions = room_sessions.reject{|_, sessions| sessions.empty? }
    return 'hidden' unless (room_sessions.keys - room_names).empty?
    room_sessions.values.select{|sessions| sessions.size > 1 }.empty? ? 'short' : 'tall'
  end
end
