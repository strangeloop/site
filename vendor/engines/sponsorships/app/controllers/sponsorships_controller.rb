class SponsorshipsController < ApplicationController
  expose(:sponsorships) { Sponsorship.visible_sponsorships_by_level_name }
end
