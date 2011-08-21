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
