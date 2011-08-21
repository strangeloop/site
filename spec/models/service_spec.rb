require 'spec_helper'

describe Service do
  [:provider, :uid, :uname].each do |field|
    it {should validate_presence_of field}
  end

  it {should belong_to :user}

  it {should have_db_column(:uemail).of_type(:string)}
end
