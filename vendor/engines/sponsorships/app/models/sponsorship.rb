class Sponsorship < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :contact
  #TODO: Fork shoulda_matchers to fix the hole in belongs_to
  #support for :class_name usage
  belongs_to :level, :class_name => 'SponsorshipLevel'

  accepts_nested_attributes_for :sponsor, :contact

  [:level, :year, :sponsor].each do |f| 
    validates f, :presence => true
  end

  def title
    sponsor.name
  end
end
