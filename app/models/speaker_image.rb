class SpeakerImage < ActiveRecord::Base

  [:uid, :db_image].each do |field|
    validates field, :presence => true
  end

  def self.find_by_uid(uid)
    self.where(:uid => uid).first
  end

end
