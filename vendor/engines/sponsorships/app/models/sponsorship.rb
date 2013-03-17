#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-

require_relative 'contact'
require_relative 'sponsor'
require_relative 'sponsorship_level'

class Sponsorship < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :contact
  belongs_to :sponsorship_level

  accepts_nested_attributes_for :sponsor, :contact

  [:sponsorship_level, :year, :sponsor].each do |f|
    validates_presence_of f
  end

  #For specific or latest year
  scope :for_year, lambda {|year| where(:year => year || Time.now.year ) }
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

    def all_years
      this_year = Time.now.year
      ((minimum('year') || this_year)..this_year).to_a.reverse
    end

    def from_year(year = nil)
      where(:year => year || maximum('year'))
    end

  end
end
