class TalkType < ActiveRecord::Base
  [:name, :description].each do |field|
    validates field, :presence => true
  end
end
