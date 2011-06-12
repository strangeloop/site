class SessionTime < ActiveRecord::Base
  def title
    return "" unless start_time && duration_hours && duration_minutes
    end_time = start_time.advance(:hours => duration_hours, :minutes => duration_minutes)
    "#{start_time.strftime('%A from %I:%M')} to #{end_time.strftime('%I:%M %p')}"
  end
end
