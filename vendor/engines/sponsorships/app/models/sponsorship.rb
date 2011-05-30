class Sponsorship < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :contact
  belongs_to :sponsorship_level

  accepts_nested_attributes_for :sponsor, :contact

  [:sponsorship_level, :year, :sponsor].each do |f| 
    validates_presence_of f
  end

  #For specific or latest year
  scope :for_year, lambda {|year| where(:year => year || maximum('year')) }
  scope :visible, where(:visible => true)

  def title
    sponsor.name
  end

  class << self
    def visible_sponsorships_by_level_name(year = nil)
      sponsorships = visible.for_year(year).includes(:sponsorship_level).order("sponsorship_levels.position, sponsorships.position")
      hash = ActiveSupport::OrderedHash.new {|h, k| h[k] = []}
      sponsorships.each{|s| hash[s.sponsorship_level.name] << s }
      hash
    end
  end
end
