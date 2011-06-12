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



class CreateConferenceSessions < ActiveRecord::Migration

  def self.up
    create_table :conference_sessions do |t|
      t.session_time_id :integer
      t.room_id :integer
      t.references :talk
      t.string :title
      t.integer :slides_id
      t.integer :position

      t.timestamps
    end

    add_index :conference_sessions, :id

    load(Rails.root.join('db', 'seeds', 'conference_sessions.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "conference_sessions"})

    Page.delete_all({:link_url => "/conference_sessions"})

    drop_table :conference_sessions
  end

end
