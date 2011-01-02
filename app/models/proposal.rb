class Proposal < ActiveRecord::Base
  [:speaker_name, :speaker_email, :title, :description].each do |field|
    validates field, :presence => true
  end

end
