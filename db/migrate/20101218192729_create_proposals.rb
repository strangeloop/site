class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.string :title
      t.string :speaker_name
      t.string :speaker_email
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
