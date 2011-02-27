class SpeakerImage < ActiveRecord::Base

  [:uid, :image].each do |field|
    validates field, :presence => true
  end

end
