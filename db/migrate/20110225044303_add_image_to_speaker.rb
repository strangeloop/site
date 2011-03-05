class AddImageToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :db_image_uid, :string
  end

  def self.down
    remove_column :speakers, :db_image_uid
  end
end
