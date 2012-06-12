class SessionTime < ActiveRecord::Base
  validates_presence_of :start_time

  validates_numericality_of :duration_hours, :greater_than => 0,
    :unless => Proc.new {|st| st.is_greater_than_zero? :duration_minutes }

  validates_numericality_of :duration_minutes, :greater_than => 0,
    :unless => Proc.new {|st| st.is_greater_than_zero? :duration_hours }

  scope :current_year, lambda {
    date_range = DateTime.parse('January 1')..DateTime.parse('December 31')
    where(:start_time => date_range).order('start_time ASC')
  }

  def is_greater_than_zero?(field)
    (self[field] || 0) > 0
  end

  def day
    start_time.strftime('%A, %B %d') #Day of the week, month day
  end

  def time_period
    "#{hr_min start_time} - #{hr_min end_time}"
  end

  def total_duration_minutes
    (duration_hours * 60) + duration_minutes
  end

  def title
    return "" unless start_time && duration_hours && duration_minutes
    "#{start_time.strftime('%A from %I:%M')} to #{end_time.strftime('%I:%M %p')}"
  end

  def end_time
    start_time.advance(:hours => duration_hours, :minutes => duration_minutes)
  end

  private
  def hr_min(time)
    time.strftime('%I:%M %p')
  end
end
