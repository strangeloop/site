require 'spec_helper'

describe SpeakerImage do
  [:uid, :db_image].each do |field| 
    it {should validate_presence_of field}
  end
end
