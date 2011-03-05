class CreateSpeakerImages < ActiveRecord::Migration
  def self.up
    create_table :speaker_images  do |t|
      t.string :uid
      t.binary :db_image
      t.timestamps
    end

    change_table :speaker_images do |t|
      t.index :uid
    end
  end

  def self.down
    drop_table :speaker_images
  end
end
