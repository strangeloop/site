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



class DatastoreImage < ActiveRecord::Base

  attr_accessible :uid, :image

  [:uid, :image].each do |field|
    validates field, :presence => true
  end

  def self.find_by_uid(uid)
    self.where(:uid => uid).first
  end

end
