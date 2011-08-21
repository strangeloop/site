#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



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
