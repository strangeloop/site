class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :bio
      t.timestamps
    end

    create_table :talks do |t|
      t.string :title
      t.text :abstract
      t.text :prereqs
      t.text :comments
      t.text :av_requirement
      t.timestamps
    end

    create_table :speakers_talks, :id => false do |t|
      t.references :speaker
      t.references :talk
    end
  end

  def self.down
    drop_table :speakers
    drop_table :talks
    drop_table :speakers_talks
  end
end
