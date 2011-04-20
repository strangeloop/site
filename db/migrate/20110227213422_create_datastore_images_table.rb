class CreateDatastoreImagesTable < ActiveRecord::Migration
  def self.up
    create_table :datastore_images  do |t|
      t.string :uid
      t.binary :image
      t.timestamps
    end

    change_table :datastore_images do |t|
      t.index :uid
    end
  end

  def self.down
    drop_table :datastore_images
  end
end
