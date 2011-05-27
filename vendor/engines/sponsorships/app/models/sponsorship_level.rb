class SponsorshipLevel < ActiveRecord::Base

  [:name, :year].each do |f| 
    validates f, :presence => true
  end

  def title
    name
  end
end
