class State < ActiveRecord::Base
  has_many :speakers
  [:abbrev, :description].each do |field|
    validates field, :presence => true
  end
end
