class Service < ActiveRecord::Base
  belongs_to :attendee_cred
  attr_accessible :provider, :uid, :uname, :uemail
  attr_accessor :twitter_id

  [:provider, :uid, :uname].each do |field|
    validates field, :presence => true
  end

  def self.find_existing_attendee_cred(provider, uid)
    Service.where("provider = ? AND uid = ?", provider, uid).first
  end

  def self.twitter_service(omniauth)
    svc = Service.new(:uname => omniauth['user_info']['name'],
                :uid => omniauth['uid'],
                :provider =>  omniauth['provider'])
    svc.twitter_id = omniauth['user_info']['screen_name']
    svc
  end

  def self.github_service(omniauth)
    Service.new(:uemail => omniauth['user_info']['email'],
                :uname =>  omniauth['user_info']['name'],
                :uid =>  omniauth['extra']['user_hash']['id'],
                :provider =>  omniauth['provider'])

  end

  def self.google_service(omniauth)
    Service.new(:uemail => omniauth['user_info']['email'],
                :uname =>  omniauth['user_info']['name'],
                :uid =>  omniauth['uid'],
                :provider =>  omniauth['provider'])
  end
end

