class Sponsorship < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :contact
  belongs_to :sponsorship_level

  accepts_nested_attributes_for :sponsor, :contact

  [:sponsorship_level, :year, :sponsor].each do |f| 
    validates_presence_of f
  end

  scope :current, where(:year => Time.now.year)

  def title
    sponsor.name
  end

  class << self
    def current_sponsorships
      current.includes(:sponsorship_level).order("sponsorship_levels.position, sponsorships.position")
    end
  end
end
