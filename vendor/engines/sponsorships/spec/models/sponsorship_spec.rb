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



require 'spec_helper'
require_relative '../../app/models/sponsorship'

describe Sponsorship do

  context "validations" do
   [:year, :sponsorship_level, :sponsor].each do |field|
     it {should validate_presence_of field}
   end

   [:sponsor, :contact].each do |relation|
     it {should belong_to relation}
   end
  end

  context "#current_sponsorships" do
    let(:platinum_sponsorship) { Factory(:platinum_sponsorship) }
    let(:platinum_sponsorship_last_year) { Factory(:platinum_sponsorship_last_year) }
    let!(:platinum_sponsorship_next_year) { Factory(:platinum_sponsorship_next_year) }
    let(:silver_sponsorship) { Factory(:silver_sponsorship) }
    let(:bronze_sponsorship) { Factory(:bronze_sponsorship) }

    before do
      bronze_sponsorship
      platinum_sponsorship_last_year
      platinum_sponsorship
      silver_sponsorship
    end

    it "only includes current year sponsorships ordered by position" do
      Sponsorship.visible_sponsorships_by_level_name.should ==
        {platinum_sponsorship.sponsorship_level.name => [platinum_sponsorship],
          silver_sponsorship.sponsorship_level.name => [silver_sponsorship],
          bronze_sponsorship.sponsorship_level.name => [bronze_sponsorship]}
    end

    it "should allow specifying year" do
      Sponsorship.visible_sponsorships_by_level_name(Time.now.year + 1).should ==
        {platinum_sponsorship_next_year.sponsorship_level.name => [platinum_sponsorship_next_year]}
    end

    it "hides non-visible sponsorships" do
      silver_sponsorship.visible = false
      silver_sponsorship.save

      Sponsorship.visible_sponsorships_by_level_name.should ==
        {platinum_sponsorship.sponsorship_level.name => [platinum_sponsorship],
          bronze_sponsorship.sponsorship_level.name => [bronze_sponsorship]}
    end

    it "returns sponsorships according to year" do
      Sponsorship.visible_sponsorships_by_level_name(Time.now.year - 1).should ==
        {platinum_sponsorship_last_year.sponsorship_level.name => [platinum_sponsorship_last_year]}
    end
  end
end
