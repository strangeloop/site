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



# TEMPORARY SOLUTION
# Remove when Rack is fixed upstream
module Rack
  module Utils
    def escape(s)
      regexp = case
        when RUBY_VERSION >= "1.9" && s.encoding === Encoding.find('UTF-8')
          /([^ a-zA-Z0-9_.-]+)/u
        else
          /([^ a-zA-Z0-9_.-]+)/n
        end
      s.to_s.gsub(regexp) {
        '%'+$1.unpack('H2'*bytesize($1)).join('%').upcase
      }.tr(' ', '+')
    end
  end
end
