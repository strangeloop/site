class AddCryptoHelpersToUserMetadata < ActiveRecord::Migration
  def self.up
    add_column :user_metadata, :reg_uid, :string
    add_column :user_metadata, :reg_date, :timestamp
  end

  def self.down
    remove_column :user_metadata, :reg_date
    remove_column :user_metadata, :reg_uid
  end
end
