class SessionTime < ActiveRecord::Base
  validates_presence_of :start_time

  validates_numericality_of :duration_hours, :greater_than => 0,
    :unless => Proc.new {|st| st.duration_minutes > 0 }

  validates_numericality_of :duration_minutes, :greater_than => 0,
    :unless => Proc.new {|st| st.duration_hours > 0 }

  def duration_hours
    self[:duration_hours] || 0
  end

  def duration_minutes
    self[:duration_minutes] || 0
  end

  def title
    return "" unless start_time && duration_hours && duration_minutes
    end_time = start_time.advance(:hours => duration_hours, :minutes => duration_minutes)
    "#{start_time.strftime('%A from %I:%M')} to #{end_time.strftime('%I:%M %p')}"
  end
end
