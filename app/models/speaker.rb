class Speaker < ActiveRecord::Base

  has_and_belongs_to_many :talks
  [:first_name, :last_name, :email, :bio].each do |field|
    validates field, :presence => true
  end

  validates_format_of :phone, :with => /\d{3}-?\d{3}-?\d{4}/,  :message => "Phone number is XXX-XXX-XXXX"
  
  validates_inclusion_of :state, :in => Carmen::state_codes,
  :message => "%{value} is not a valid state code"

  validates_inclusion_of :country, :in => Carmen::country_codes,
  :message => "%{value} is not a valid state code"

  image_accessor :image

  before_create AddConfYear

end
