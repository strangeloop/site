class Speaker < ActiveRecord::Base

  has_and_belongs_to_many :talks
  [:first_name, :last_name, :email, :bio].each do |field|
    validates field, :presence => true
  end

  validates_inclusion_of :state, :in => Carmen::state_codes,
  :message => "%{value} is not a valid state code"
end
