class Speaker < ActiveRecord::Base
  belongs_to :state
  has_and_belongs_to_many :talks
end