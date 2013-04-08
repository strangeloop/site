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



require 'dragonfly'

Rails.configuration.after_initialize do
  app = Dragonfly[:images]
  app.configure_with(:rails) do |c|
    c.datastore = RelationalDragonflyStore.new
    c.url_format = '/system/images'
    c.secret = Refinery::Setting.find_or_set(:dragonfly_secret,
                                          Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
  end
end


