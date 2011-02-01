class Talk < ActiveRecord::Base

  [:title, :abstract].each do |field|
    validates field, :presence => true
  end

  has_enumeration :video_approval, [:yes, :no, :maybe]
  has_enumeration :talk_type, :deep => "Deep Dive", :intro => "Intro", :survey => "Survey"

  belongs_to :track
  belongs_to :talk_length

  has_and_belongs_to_many :speakers

  before_create AddConfYear

  accepts_nested_attributes_for :speakers

end
