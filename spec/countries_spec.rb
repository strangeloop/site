require 'spec_helper'

describe Country do
  [:abbrev, :description].each do |field|
    it {should validate_presence_of field}
  end
end
