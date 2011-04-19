class AddRefineryImageToSpeaker < ActiveRecord::Migration
  def self.up
    add_column :speakers, :image_id, :integer
  end

  def self.down
    remove_column :speakers, :image_id
  end
end
