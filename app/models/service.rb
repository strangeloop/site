class Service < ActiveRecord::Base
  belongs_to :attendee_cred
  attr_accessible :provider, :uid, :uname, :uemail

  [:provider, :uid, :uname].each do |field|
    validates field, :presence => true
  end

  def self.find_existing_user(omniauth_token)
    Service.where("provider = ? AND uid = ?", omniauth_token['provider'],  omniauth_token['extra']['user_hash']['id']).first
  end
end

