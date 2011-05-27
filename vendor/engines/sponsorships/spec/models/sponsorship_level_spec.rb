require 'spec_helper'

describe SponsorshipLevel do
  [:name, :year].each do |f|
    it {should validate_presence_of f }
  end
end
