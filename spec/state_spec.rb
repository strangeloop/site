require 'spec_helper'

describe State do
  it {should validate_presence_of :abbrev}
  it {should validate_presence_of :description}
end
