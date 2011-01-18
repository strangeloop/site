require 'spec_helper'

describe Track do
  [:abbrev, :description].each do |field|
    it {should validate_presence_of field}
  end
end
