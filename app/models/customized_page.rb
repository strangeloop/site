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



#This customization of the Page class adds cache clearing after the
#expire_page_cache callback, which is invoked on page adds and
#deletes.  This customization clears the header & footer caches
#whenever pages are added or removed so that they navigation
#bar links at the top and bottom of all pages can be regenerated.
class PageCustomizer
  def self.load
    Refinery::Page.class_eval do
      class << self
        alias orig_expire_page_caching expire_page_caching

        def expire_page_caching
          orig_expire_page_caching
          [".*header.*", ".*footer.*"].each{|key| delete_cache(key)}
        end

        private
        def delete_cache(key)
          begin
            Rails.cache.delete_matched(/#{key}/)
          rescue NotImplementedError
            Rails.cache.clear
            warn "**** [REFINERY] The cache store you are using is not compatible with Rails.cache#delete_matched - clearing entire cache instead ***"
          end
        end
      end
    end
  end
end

