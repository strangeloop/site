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



Autotest.add_hook(:initialize) do |at|
  at.add_exception(%r{vendor/cache})

  at.add_mapping(%r%^vendor/engines/\w+/spec/(models|controllers|routing|views|helpers|mailers|requests|lib)/.*rb$%) { |filename, _|
    filename
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/app/models/(.*)\.rb$%) { |_, m|
    ["vendor/engines/#{m[1]}/spec/models/#{m[2]}_spec.rb"]
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/app/views/(.*)$%) { |_, m|
    at.files_matching %r%^vendor/engines/#{m[1]}/spec/views/#{m[2]}_spec.rb$%
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/app/controllers/(.*)\.rb$%) { |_, m|
    if m[2] == "application"
      at.files_matching %r%^vendor/engines/#{m[1]}/spec/controllers/.*_spec\.rb$%
    else
      ["vendor/engines/#{m[1]}/spec/controllers/#{m[2]}_spec.rb"]
    end
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/app/helpers/(.*)_helper\.rb$%) { |_, m|
    if m[2] == "application" then
      at.files_matching(%r%^vendor/engines/#{m[1]}/spec/(views|helpers)/.*_spec\.rb$%)
    else
      ["vendor/engines/#{m[1]}/spec/helpers/#{m[2]}_helper_spec.rb"] + at.files_matching(%r%^spec\/views\/#{m[2]}/.*_spec\.rb$%)
    end
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/config/routes\.rb$%) { |_, m|
    at.files_matching %r%^vendor/engines/#{m[1]}/spec/(controllers|routing|views|helpers)/.*_spec\.rb$%
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/(spec/(spec_helper|support/.*)|config/(boot|environment(s/test)?))\.rb$%) { |_, m|
    at.files_matching %r%^vendor/engines/#{m[1]}/spec/(models|controllers|routing|views|helpers)/.*_spec\.rb$%
  }
  at.add_mapping(%r%^vendor/engines/(\w+)/lib/(.*)\.rb$%) { |_, m|
    ["vendor/engines/#{m[1]}/spec/lib/#{m[2]}_spec.rb"]
  }
end


