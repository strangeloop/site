class ChangeImageColumnName < ActiveRecord::Migration
  def self.up
    change_table :speaker_images do |t|
      t.remove :image
      t.binary :db_image
    end
    change_table :speakers do |t|
      t.remove :image_uid
      t.string :db_image_uid
    end
  end

  def self.down
    change_table :speaker_images do |t|
      t.binary :image
      t.remove :db_image
    end
    change_table :speakers do |t|
      t.remove :db_image_uid
      t.string :image_uid
    end
    
  end
end
