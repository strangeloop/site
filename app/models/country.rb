class Country < ActiveRecord::Base
  [:abbrev, :description].each do |field|
    validates field, :presence => true
  end
end
