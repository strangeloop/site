class Speaker < ActiveRecord::Base

  has_and_belongs_to_many :talks
  [:first_name, :last_name, :email, :bio].each do |field|
    validates field, :presence => true
  end

  validates_length_of :bio, :maximum => 800

  belongs_to :image

  before_create AddConfYear

  def twitter_id= id
    self[:twitter_id] = id.try(:gsub, '@', '')
  end
end
