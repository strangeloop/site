class SessionTime < ActiveRecord::Base
  def title
    "#{start_time.strftime('%A from %I:%M')} to #{end_time.strftime('%I:%M %p')}"
  end
end
