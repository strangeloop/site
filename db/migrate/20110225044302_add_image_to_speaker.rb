class AddImageToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :image_uid, :string
  end

  def self.down
    remove_column :speakers, :image_uid
  end
end
