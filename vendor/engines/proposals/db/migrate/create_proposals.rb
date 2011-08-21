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



class CreateProposals < ActiveRecord::Migration

  def self.up
    create_table :proposals do |t|
      t.string :status
      t.integer :position

      t.timestamps
    end

    add_index :proposals, :id

    load(Rails.root.join('db', 'seeds', 'proposals.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "proposals"})

    Page.delete_all({:link_url => "/proposals"})

    drop_table :proposals
  end

end
