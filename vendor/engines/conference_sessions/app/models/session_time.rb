class SessionTime < ActiveRecord::Base
  validates_presence_of :start_time

  validates_numericality_of :duration_hours, :greater_than => 0,
    :unless => Proc.new {|st| st.is_greater_than_zero? :duration_minutes }

  validates_numericality_of :duration_minutes, :greater_than => 0,
    :unless => Proc.new {|st| st.is_greater_than_zero? :duration_hours }

  scope :current_year, lambda {
    date_range = DateTime.parse('January 1')..DateTime.parse('December 31')
    where(:start_time => date_range)
  }

  def is_greater_than_zero?(field)
    (self[field] || 0) > 0
  end

  def title
    return "" unless start_time && duration_hours && duration_minutes
    end_time = start_time.advance(:hours => duration_hours, :minutes => duration_minutes)
    "#{start_time.strftime('%A from %I:%M')} to #{end_time.strftime('%I:%M %p')}"
  end
end
