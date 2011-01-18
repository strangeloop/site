require 'spec_helper'

describe TalkType do
  [:name, :description].each do |field|
    it {should validate_presence_of field}
  end
end
