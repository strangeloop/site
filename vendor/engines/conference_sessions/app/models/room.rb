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


class Room < ActiveRecord::Base
  before_create AddConfYear

  validates_uniqueness_of :name, :scope => :conf_year, :message => 'Rooms must have unique names within a conference year'

  [:name, :capacity].each do |field|
    validates_presence_of field
  end

  scope :current_year, lambda { where(:conf_year => Time.now.year).order('capacity ASC') }

  def title
    "#{name} (cap. #{capacity})"
  end

  def to_s
    name
  end
end
