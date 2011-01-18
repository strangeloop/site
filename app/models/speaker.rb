class Speaker < ActiveRecord::Base
  belongs_to :state
  has_and_belongs_to_many :talks
  [:first_name, :last_name, :email, :bio].each do |field|
    validates field, :presence => true
  end
end
