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



###  uncomment any of the following requires applicable for your system
###  and then copy this to .autotest if you are using the ZenTest autotest.
# require "autotest/restart"
# require "test_notifier/runner/autotest"
# require "redgreen/autotest"
# require "autotest/timestamp"

# adds exceptions from .gitignore file, please modify exceptions there!
imported_exceptions =  IO.readlines('.gitignore').inject([]) do |acc, line|
  acc << line.strip if line.to_s[0] != '#' && line.strip != ''; acc
end

Autotest.add_hook :initialize do |autotest|
  imported_exceptions.each do |exception|
    autotest.add_exception(exception)
  end
end
