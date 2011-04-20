require 'spec_helper'

describe DatastoreImage do
  [:uid, :image].each do |field| 
    it {should validate_presence_of field}
  end
end
