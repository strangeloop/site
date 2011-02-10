require 'spec_helper'

describe Carmen do
  it "contains state codes" do
    Carmen.state_codes.index("MO").should > 0
    Carmen.state_codes.index("IL").should > 0
    Carmen.state_codes.index("IA").should > 0
    Carmen.state_codes.index("CA").should > 0
    Carmen.state_codes.index("KS").should > 0
  end

  it "contains state descriptions" do
    Carmen.state_names.index("Missouri").should > 0
    Carmen.state_names.index("Illinois").should > 0
    Carmen.state_names.index("Iowa").should > 0
    Carmen.state_names.index("California").should > 0
    Carmen.state_names.index("Kansas").should > 0
  end

end
