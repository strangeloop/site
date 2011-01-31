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
