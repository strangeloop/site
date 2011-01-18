class TalkLength < ActiveRecord::Base

  [:description].each do |field|
    validates field, :presence => true
  end
end
