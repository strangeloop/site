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



class CreateSponsorships < ActiveRecord::Migration

  def self.up
    create_table :sponsors do |t|
      t.string :name
      t.integer :image_id
      t.text :description
      t.string :url

      t.timestamps
    end

    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end

    create_table :sponsorship_levels do |t|
      t.string :name
      t.integer :year
      t.integer :position

      t.timestamps
    end

    create_table :sponsorships do |t|
      t.integer :sponsor_id
      t.integer :contact_id
      t.integer :sponsorship_level_id
      t.boolean :visible
      t.integer :year
      t.integer :position

      t.timestamps
    end

    add_index :sponsorships, :id

    load(Rails.root.join('db', 'seeds', 'sponsorships.rb'))

  end

  def self.down
    UserPlugin.destroy_all({:name => "sponsorships"})

    Page.delete_all({:link_url => "/sponsorships"})

    drop_table :sponsorships
    drop_table :sponsorship_levels
    drop_table :contacts
    drop_table :sponsors
  end

end
