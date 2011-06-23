class Track < ActiveRecord::Base
  before_create AddConfYear  

  validates_presence_of :name
  
  scope :current_year, lambda { where(:conf_year => Time.now.year).order('name ASC') }

  def color
    self[:color] || '000'
  end

  def title
    name
  end
end
